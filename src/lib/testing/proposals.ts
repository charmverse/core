import type { Page, Post, Prisma, ProposalCategory, ProposalStatus, ProposalEvaluationType } from '@prisma/client';
import { v4 } from 'uuid';

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
};

/**
 * Creates a proposal with the linked authors and reviewers
 */
export async function generateProposal({
  categoryId,
  userId,
  spaceId,
  proposalStatus = 'draft',
  title = 'Proposal',
  authors = [],
  reviewers = [],
  deletedAt = null,
  content,
  archived,
  evaluationType,
  customProperties,
  snapshotProposalId
}: GenerateProposalInput): Promise<ProposalWithUsers & { page: Page }> {
  const proposalId = v4();

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
      reviewers: !reviewers.length
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
    path: `path-${v4()}`,
    title,
    type: 'proposal',
    createdBy: userId,
    spaceId,
    deletedAt,
    proposalId,
    content,
    snapshotProposalId
  });

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
              path: `post-${v4()}`,
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
  if (!categoryId) {
    throw new InvalidInputError('Proposal category is required');
  }

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
