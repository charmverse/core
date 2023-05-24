import type { Page, Prisma, Thread, Comment } from '@prisma/client';
import { v4 } from 'uuid';

import { prisma } from '../../prisma-client';
import type { PageNode, PageWithPermissions } from '../pages/interfaces';
import type { PagePermissionAssignmentByValues } from '../permissions/pages/interfaces';

type OptionalPagePermissionsToGenerate = {
  pagePermissions?: (PagePermissionAssignmentByValues & { inheritedFromPermission?: string })[];
};

type PageGenerateArgs = Pick<Page, 'createdBy' | 'spaceId'> &
  Partial<
    Pick<
      Page,
      | 'id'
      | 'content'
      | 'contentText'
      | 'parentId'
      | 'title'
      | 'type'
      | 'deletedAt'
      | 'path'
      | 'proposalId'
      | 'bountyId'
      | 'index'
    >
  > &
  OptionalPagePermissionsToGenerate;

const emptyDocument = {
  type: 'doc',
  content: [
    {
      type: 'paragraph'
    }
  ]
};

export function generatePage({
  id,
  createdBy,
  spaceId,
  content,
  contentText,
  pagePermissions,
  parentId,
  title,
  type,
  path,
  proposalId,
  bountyId,
  deletedAt,
  index
}: PageGenerateArgs): Promise<Page> {
  return prisma.page.create({
    data: {
      id: id ?? v4(),
      deletedAt,
      title: title ?? 'Page title',
      path: path ?? `page-${v4()}`,
      type: type ?? 'page',
      updatedBy: createdBy,
      content: content ?? emptyDocument,
      contentText: contentText ?? '',
      parentId,
      index,
      proposal: proposalId
        ? {
            connect: {
              id: proposalId
            }
          }
        : undefined,
      bounty: bountyId
        ? {
            connect: {
              id: bountyId
            }
          }
        : undefined,
      author: {
        connect: {
          id: createdBy
        }
      },
      space: {
        connect: {
          id: spaceId
        }
      },
      permissions:
        pagePermissions && pagePermissions.length > 0
          ? {
              createMany: {
                data: pagePermissions.map((permissionInput) => {
                  return {
                    permissionLevel: permissionInput.permissionLevel,
                    inheritedFromPermission: permissionInput.inheritedFromPermission,
                    public: permissionInput.assignee.group === 'public' ? true : undefined,
                    roleId: permissionInput.assignee.group === 'role' ? permissionInput.assignee.id : undefined,
                    spaceId: permissionInput.assignee.group === 'space' ? permissionInput.assignee.id : undefined,
                    userId: permissionInput.assignee.group === 'user' ? permissionInput.assignee.id : undefined
                  } as Omit<Prisma.PagePermissionCreateManyInput, 'pageId'>;
                })
              }
            }
          : undefined
    }
  });
}
/**
 * This function provides a subset of Pages, which is enough to create simulated trees and assess tree resolution behaviour
 */
export function generatePageNode({
  // Default values for props reflects our app defaults
  id = v4(),
  parentId = null,
  type = 'page',
  index = -1,
  deletedAt = null,
  createdAt = new Date(),
  title = 'Untitled',
  spaceId = v4()
}: Partial<PageNode<Pick<Page, 'title'>>>): PageNode<Pick<Page, 'title'>> {
  return {
    id,
    type,
    parentId,
    index,
    createdAt,
    deletedAt,
    title,
    spaceId
  };
}

export async function getPageWithPermissions(pageId: string): Promise<PageWithPermissions> {
  return prisma.page.findUniqueOrThrow({
    where: {
      id: pageId
    },
    include: {
      permissions: {
        include: {
          sourcePermission: true
        }
      }
    }
  });
}
export async function generateCommentWithThreadAndPage({
  userId,
  spaceId,
  commentContent
}: {
  userId: string;
  spaceId: string;
  commentContent: string;
} & OptionalPagePermissionsToGenerate): Promise<{ page: Page; thread: Thread; comment: Comment }> {
  const page = await generatePage({
    createdBy: userId,
    spaceId
  });

  const thread = await prisma.thread.create({
    data: {
      context: 'Random context',
      resolved: false,
      page: {
        connect: {
          id: page.id
        }
      },
      user: {
        connect: {
          id: userId
        }
      },
      space: {
        connect: {
          id: spaceId
        }
      }
    }
  });

  const comment = await prisma.comment.create({
    data: {
      page: {
        connect: {
          id: page.id
        }
      },
      content: commentContent,
      thread: {
        connect: {
          id: thread.id
        }
      },
      user: {
        connect: {
          id: userId
        }
      },
      space: {
        connect: {
          id: spaceId
        }
      }
    }
  });

  return {
    page,
    thread,
    comment
  };
}
