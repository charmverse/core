import type { Page, Post, Prisma, ProposalEvaluation, ProposalStatus, ProposalEvaluationType } from '@prisma/client';
import { ProposalSystemRole } from '@prisma/client';
import type { TargetPermissionGroup } from 'permissions';
import { v4 as uuid } from 'uuid';

import { prisma } from '../../prisma-client';
import { InvalidInputError } from '../errors';
import type { ProposalReviewerInput, ProposalWithUsers, PermissionJson } from '../proposals/interfaces';

import { generatePage } from './pages';

export type ProposalWithUsersAndPageMeta = ProposalWithUsers & { page: Pick<Page, 'title' | 'path'> };

export type ProposalEvaluationTestInput = Partial<
  Pick<
    Prisma.ProposalEvaluationCreateManyInput,
    'id' | 'title' | 'completedAt' | 'snapshotExpiry' | 'snapshotId' | 'result' | 'voteId' | 'type'
  >
> & {
  rubricCriteria?: Partial<
    Pick<Prisma.ProposalRubricCriteriaCreateManyInput, 'title' | 'description' | 'parameters'>
  >[];
  reviewers: ({ group: Extract<ProposalSystemRole, 'space_member'> } | TargetPermissionGroup<'role' | 'user'>)[];
  permissions: PermissionJson[];
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
  proposalStatus?: ProposalStatus;
  title?: string;
  content?: any;
  evaluationType?: ProposalEvaluationType;
  customProperties?: Record<string, any>;
  snapshotProposalId?: string;
  evaluationInputs?: ProposalEvaluationTestInput[];
};

type TypedEvaluation = ProposalEvaluation & { permissions: PermissionJson[] };
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
  title = 'Proposal',
  authors = [],
  reviewers,
  deletedAt = null,
  content,
  archived,
  evaluationType,
  customProperties,
  snapshotProposalId,
  evaluationInputs
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
      evaluationType,
      space: {
        connect: {
          id: spaceId
        }
      },
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
          },
      reviewers: !reviewers?.length
        ? undefined
        : {
            createMany: {
              data: reviewers
            }
          }
    }
  });

  await generatePage({
    id: proposalId,
    contentText: '',
    path: `path-${uuid()}`,
    title,
    type: 'proposal',
    createdBy: userId,
    spaceId,
    deletedAt,
    proposalId,
    content,
    snapshotProposalId
  });

  if (evaluationInputs) {
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
        input.permissions.map((evaluationPermission) => ({
          ...evaluationPermission,
          evaluationId: input.id
        }))
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
              title: input.title ?? input.type,
              type: input.type,
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
      evaluations: {
        include: {
          permissions: true
        }
      },
      reviewers: true,
      page: true
    }
  });

  return result as GenerateProposalResponse;
}
export async function convertPostToProposal({ post, userId }: { post: Post; userId: string }) {
  await prisma.post.update({
    where: { id: post.id },
    data: {
      proposal: {
        create: {
          createdBy: userId,
          status: 'draft',
          space: {
            connect: {
              id: post.spaceId
            }
          },
          page: {
            create: {
              author: {
                connect: {
                  id: userId
                }
              },
              space: {
                connect: {
                  id: post.spaceId
                }
              },
              contentText: post.contentText,
              content: post.content as any,
              path: `post-${uuid()}`,
              title: post.title,
              type: 'proposal',
              updatedBy: userId
            }
          }
        }
      }
    }
  });
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

export async function convertPageToProposal({
  pageId,
  userId
}: {
  pageId: string;
  proposalCategoryId?: string;
  userId?: string;
}): Promise<void> {
  const page = await prisma.page.findUniqueOrThrow({
    where: { id: pageId },
    select: { createdBy: true, spaceId: true }
  });

  const { page: proposalPage } = await generateProposal({
    userId: userId ?? page.createdBy,
    spaceId: page.spaceId
  });

  await prisma.page.update({
    where: {
      id: pageId
    },
    data: {
      convertedProposalId: proposalPage.id
    }
  });
}
