import type {
  Page,
  PageType,
  Prisma,
  ProposalEvaluation,
  ProposalEvaluationType,
  ProposalOperation,
  ProposalReviewer,
  ProposalStatus
} from '@prisma/client';
import { ProposalSystemRole } from '@prisma/client';
import type { TargetPermissionGroup } from 'permissions';
import { v4 as uuid } from 'uuid';

import { prisma } from '../../prisma-client';
import { InvalidInputError } from '../errors';
import type { PermissionJson, ProposalReviewerInput, ProposalWithUsers } from '../proposals/interfaces';

import { generatePage } from './pages';

export type ProposalWithUsersAndPageMeta = ProposalWithUsers & { page: Pick<Page, 'title' | 'path'> };

export type ProposalEvaluationTestInput = Partial<Prisma.ProposalEvaluationCreateManyInput> & {
  evaluationType: ProposalEvaluationType;
  rubricCriteria?: Partial<
    Pick<Prisma.ProposalRubricCriteriaCreateManyInput, 'title' | 'description' | 'parameters'>
  >[];
  reviewers: ({ group: Extract<ProposalSystemRole, 'space_member'> } | TargetPermissionGroup<'role' | 'user'>)[];
  permissions: {
    assignee: { group: ProposalSystemRole } | TargetPermissionGroup<'role' | 'user'>;
    operation: Extract<ProposalOperation, 'edit' | 'view' | 'move' | 'comment'>;
  }[];
};
/**
 * @reviewers - Valid only for old tests, use `evaluationInputs` instead to define reviewers and permissions
 for that step
*/
export type GenerateProposalInput = {
  deletedAt?: Page['deletedAt'];
  archived?: boolean;
  userId: string;
  spaceId: string;
  authors?: string[];
  reviewers?: ProposalReviewerInput[];
  pageType?: PageType;
  proposalStatus?: ProposalStatus;
  title?: string;
  content?: any;
  evaluationType?: ProposalEvaluationType;
  customProperties?: Record<string, any>;
  snapshotProposalId?: string;
  evaluationInputs?: ProposalEvaluationTestInput[];
  workflowId?: string;
  selectedCredentialTemplateIds?: string[];
  sourceTemplateId?: string;
};

type TypedEvaluation = ProposalEvaluation & { permissions: PermissionJson[]; reviewers: ProposalReviewer[] };
type GenerateProposalResponse = ProposalWithUsers & { page: Page; evaluations: TypedEvaluation[] };

/**
 * Creates a proposal with the linked authors and reviewers
 *
 * @reviewers Valid only for old tests, use `evaluationInputs` instead to define reviewers and permissions
 */
export async function generateProposal({
  userId,
  spaceId,
  proposalStatus = 'draft',
  pageType = 'proposal',
  title = 'Proposal',
  authors = [],
  reviewers,
  deletedAt = null,
  content,
  archived,
  evaluationType,
  customProperties,
  snapshotProposalId,
  selectedCredentialTemplateIds,
  sourceTemplateId,
  evaluationInputs,
  workflowId
}: GenerateProposalInput): Promise<GenerateProposalResponse> {
  if (reviewers && evaluationInputs) {
    throw new InvalidInputError(
      'Cannot define both reviewers and evaluationInputs. Reviewers are a legacy feature. For new proposal tests, you should use the evaluation inputs field'
    );
  }

  const proposalId = uuid();

  await prisma.proposal.create({
    data: {
      id: proposalId,
      createdBy: userId,
      status: proposalStatus,
      archived,
      space: {
        connect: {
          id: spaceId
        }
      },
      workflow: workflowId
        ? {
            connect: {
              id: workflowId
            }
          }
        : undefined,
      selectedCredentialTemplates: selectedCredentialTemplateIds,
      fields: customProperties
        ? {
            properties: customProperties
          }
        : undefined,
      authors: !authors.length
        ? undefined
        : {
            createMany: {
              data: authors.map((authorId) => ({ userId: authorId }))
            }
          }
    }
  });

  await generatePage({
    id: proposalId,
    contentText: '',
    path: `path-${uuid()}`,
    title,
    type: pageType,
    createdBy: userId,
    spaceId,
    deletedAt,
    proposalId,
    content,
    snapshotProposalId,
    sourceTemplateId
  });

  if (evaluationInputs || evaluationType) {
    evaluationInputs = evaluationType
      ? [
          {
            id: uuid(),
            index: 0,
            evaluationType,
            title: evaluationType,
            reviewers: reviewers || [],
            permissions: []
          }
        ]
      : evaluationInputs || [];
    const evaluationInputsWithIdAndIndex = evaluationInputs.map((input, index) => ({
      ...input,
      id: input.id ?? uuid(),
      index
    }));

    const evaluationRubricsToCreate = evaluationInputsWithIdAndIndex.flatMap((input, index) =>
      (input.rubricCriteria ?? []).map(
        (criteria) =>
          ({
            parameters: criteria.parameters ?? {},
            proposalId,
            title: criteria.title,
            type: 'range',
            description: criteria.description,
            evaluationId: input.id,
            index
          }) as Prisma.ProposalRubricCriteriaCreateManyInput
      )
    );

    const evaluationPermissionsToCreate: Prisma.ProposalEvaluationPermissionCreateManyInput[] =
      evaluationInputsWithIdAndIndex.flatMap((input) =>
        input.permissions.map(
          (evaluationPermission) =>
            ({
              evaluationId: input.id,
              operation: evaluationPermission.operation,
              roleId: evaluationPermission.assignee.group === 'role' ? evaluationPermission.assignee.id : undefined,
              userId: evaluationPermission.assignee.group === 'user' ? evaluationPermission.assignee.id : undefined,
              systemRole: ProposalSystemRole[evaluationPermission.assignee.group as ProposalSystemRole]
                ? evaluationPermission.assignee.group
                : undefined
            }) as Prisma.ProposalEvaluationPermissionCreateManyInput
        )
      );

    const evaluationReviewersToCreate: Prisma.ProposalReviewerCreateManyInput[] =
      evaluationInputsWithIdAndIndex.flatMap(
        (input) =>
          input.reviewers?.map(
            (reviewer) =>
              ({
                proposalId,
                evaluationId: input.id,
                roleId: reviewer.group === 'role' ? reviewer.id : undefined,
                userId: reviewer.group === 'user' ? reviewer.id : undefined,
                systemRole: ProposalSystemRole[reviewer.group as ProposalSystemRole] ? reviewer.group : undefined
              }) as Prisma.ProposalReviewerCreateManyInput
          )
      );

    await prisma.$transaction([
      prisma.proposalEvaluation.createMany({
        data: evaluationInputsWithIdAndIndex.map(
          (input) =>
            ({
              id: input.id,
              index: input.index,
              proposalId,
              title: input.title ?? input.evaluationType,
              type: input.evaluationType,
              completedAt: input.completedAt,
              result: input.result,
              snapshotExpiry: input.snapshotExpiry,
              snapshotId: input.snapshotId,
              voteId: input.voteId
            }) as Prisma.ProposalEvaluationCreateManyInput
        ),
        skipDuplicates: true
      }),
      prisma.proposalEvaluationPermission.createMany({
        data: evaluationPermissionsToCreate
      }),
      prisma.proposalReviewer.createMany({
        data: evaluationReviewersToCreate
      }),
      prisma.proposalRubricCriteria.createMany({
        data: evaluationRubricsToCreate
      })
    ]);
  }

  const result = await prisma.proposal.findUniqueOrThrow({
    where: {
      id: proposalId
    },
    include: {
      category: true,
      authors: true,
      reviewers: true,
      page: true,
      evaluations: {
        include: {
          permissions: true,
          reviewers: true
        }
      }
    }
  });

  return result as GenerateProposalResponse;
}

export async function generateProposalNotes({
  proposalPageId,
  createdBy,
  content
}: {
  proposalPageId: string;
  spaceId?: string;
  createdBy?: string;
  content?: any | null;
}): Promise<Omit<Page, 'parentId'> & { parentId: string }> {
  const page = await prisma.page.findUniqueOrThrow({ where: { id: proposalPageId } });
  return generatePage({
    type: 'proposal_notes',
    title: '',
    parentId: proposalPageId,
    createdBy: createdBy || page.createdBy,
    content,
    spaceId: page.spaceId
  }) as Promise<Omit<Page, 'parentId'> & { parentId: string }>;
}

export async function generateProposalTemplate({
  spaceId,
  userId,
  authors,
  deletedAt,
  proposalStatus,
  reviewers
}: GenerateProposalInput): Promise<ProposalWithUsers> {
  const proposal = await generateProposal({
    spaceId,
    userId,
    authors,
    deletedAt,
    proposalStatus,
    reviewers
  });

  const convertedToTemplate = await prisma.page.update({
    data: {
      type: 'proposal_template'
    },
    where: {
      id: proposal.id
    },
    include: {
      proposal: {
        include: {
          authors: true,
          reviewers: true,
          category: true
        }
      }
    }
  });

  return convertedToTemplate.proposal as ProposalWithUsers;
}
