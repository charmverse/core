import type { Page, Post, ProposalCategory, ProposalStatus } from '@prisma/client';
import { v4 } from 'uuid';

import { prisma } from '../../db';
import type { ProposalReviewerInput, ProposalWithUsers } from '../proposals/interfaces';
import { stringToColor } from '../utilities/strings';

import { generatePage } from './pages';

export async function generateProposalCategory({
  spaceId,
  title = `Category-${Math.random()}`
}: {
  spaceId: string;
  title?: string;
}): Promise<Required<ProposalCategory>> {
  return prisma.proposalCategory.create({
    data: {
      title,
      space: { connect: { id: spaceId } },
      color: stringToColor(title)
    }
  });
}

export type ProposalWithUsersAndPageMeta = ProposalWithUsers & { page: Pick<Page, 'title' | 'path'> };

/**
 * Creates a proposal with the linked authors and reviewers
 */
export async function generateProposal({
  categoryId,
  userId,
  spaceId,
  proposalStatus = 'draft',
  authors = [],
  reviewers = [],
  deletedAt = null
}: {
  deletedAt?: Page['deletedAt'];
  categoryId: string;
  userId: string;
  spaceId: string;
  authors?: string[];
  reviewers?: ProposalReviewerInput[];
  proposalStatus?: ProposalStatus;
}): Promise<ProposalWithUsersAndPageMeta> {
  const proposalId = v4();

  const result = await generatePage<{ proposal: ProposalWithUsers }>({
    data: {
      id: proposalId,
      contentText: '',
      path: `path-${v4()}`,
      title: 'Proposal',
      type: 'proposal',
      author: {
        connect: {
          id: userId
        }
      },
      updatedBy: userId,
      space: {
        connect: {
          id: spaceId
        }
      },
      deletedAt,
      proposal: {
        create: {
          category: { connect: { id: categoryId } },
          id: proposalId,
          createdBy: userId,
          status: proposalStatus,
          space: {
            connect: {
              id: spaceId
            }
          },
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
      }
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

  return { ...result.proposal, page: { title: result.title, path: result.path } };
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
