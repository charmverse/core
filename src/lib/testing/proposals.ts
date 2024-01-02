import type {
  Page,
  Post,
  Prisma,
  ProposalCategory,
  ProposalStatus,
  ProposalEvaluationType,
  ProposalOperation
} from '@prisma/client';
import { ProposalSystemRole } from '@prisma/client';
import type { TargetPermissionGroup } from 'permissions';
import { v4 as uuid } from 'uuid';

import { prisma } from '../../prisma-client';
import { randomThemeColor } from '../branding/colors';
import { InvalidInputError } from '../errors';
import type { ProposalCategoryPermissionAssignment } from '../permissions/proposals/interfaces';
import type { ProposalReviewerInput, ProposalWithUsers } from '../proposals/interfaces';

import { generatePage } from './pages';

export async function generateProposalCategory({
  spaceId,
  title = `Category-${Math.random()}`,
  proposalCategoryPermissions
}: {
  spaceId: string;
  title?: string;
  proposalCategoryPermissions?: Pick<ProposalCategoryPermissionAssignment, 'assignee' | 'permissionLevel'>[];
}): Promise<Required<ProposalCategory>> {
  return prisma.proposalCategory.create({
    data: {
      title,
      space: { connect: { id: spaceId } },
      color: randomThemeColor(),
      proposalCategoryPermissions:
        proposalCategoryPermissions && proposalCategoryPermissions.length > 0
          ? {
              createMany: {
                data: proposalCategoryPermissions.map((p) => {
                  return {
                    permissionLevel: p.permissionLevel,
                    public: p.assignee.group === 'public' ? true : undefined,
                    roleId: p.assignee.group === 'role' ? p.assignee.id : undefined,
                    spaceId: p.assignee.group === 'space' ? p.assignee.id : undefined
                  } as Omit<Prisma.ProposalCategoryPermissionCreateManyInput, 'proposalCategoryId'>;
                })
              }
            }
          : undefined
    }
  });
}

export type ProposalWithUsersAndPageMeta = ProposalWithUsers & { page: Pick<Page, 'title' | 'path'> };

export type ProposalEvaluationTestInput = Partial<
  Pick<
    Prisma.ProposalEvaluationCreateManyInput,
    'id' | 'title' | 'completedAt' | 'snapshotExpiry' | 'snapshotId' | 'result' | 'voteId'
  >
> & {
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
  categoryId?: string;
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

/**
 * Creates a proposal with the linked authors and reviewers
 *
 * @reviewers Valid only for old tests, use `evaluationInputs` instead to define reviewers and permissions
 */
export async function generateProposal({
  categoryId,
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
}: GenerateProposalInput): Promise<ProposalWithUsers & { page: Page }> {
  if (reviewers && evaluationInputs) {
    throw new InvalidInputError(
      'Cannot define both reviewers and evaluationInputs. Reviewers are a legacy feature. For new proposal tests, you should use the evaluation inputs field'
    );
  }

  const proposalId = uuid();

  await prisma.proposal.create({
    data: {
      category: !categoryId
        ? { create: { color: randomThemeColor(), title: `Category ${Math.random()}`, spaceId } }
        : { connect: { id: categoryId } },
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
              data: (reviewers ?? []).map((r) => {
                return {
                  userId: r.group === 'user' ? r.id : undefined,
                  roleId: r.group === 'role' ? r.id : undefined
                };
              })
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

    const [evaluationSteps, evaluationPermissions, evaluationReviewers] = await prisma.$transaction([
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
      page: true
    }
  });

  return result as ProposalWithUsers & { page: Page };
}
export async function convertPostToProposal({
  post,
  userId,
  categoryId
}: {
  post: Post;
  userId: string;
  categoryId: string;
}) {
  await prisma.post.update({
    where: { id: post.id },
    data: {
      proposal: {
        create: {
          createdBy: userId,
          status: 'draft',
          category: {
            connect: {
              id: categoryId
            }
          },
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
  reviewers,
  categoryId
}: GenerateProposalInput): Promise<ProposalWithUsers> {
  const proposal = await generateProposal({
    categoryId,
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
  proposalCategoryId,
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
    spaceId: page.spaceId,
    categoryId: proposalCategoryId
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
