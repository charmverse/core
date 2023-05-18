import { v4 } from 'uuid';

import type { Post, PostCategory, PostComment, Prisma } from '../../prisma';
import { prisma } from '../../prisma-client';
import { stringToValidPath } from '../utilities/strings';

export async function generatePostCategory({
  spaceId,
  name = `Category-${Math.random()}`
}: {
  spaceId: string;
  name?: string;
}): Promise<Required<PostCategory>> {
  return prisma.postCategory.create({
    data: {
      name,
      spaceId,
      path: stringToValidPath(name, 50)
    }
  });
}

export type CreatePostCommentInput = {
  content: any;
  contentText: string;
  parentId?: string;
};

export async function generatePostWithComment({
  userId,
  spaceId,
  categoryId
}: {
  spaceId: string;
  userId: string;
  categoryId?: string;
}) {
  const commentInput: CreatePostCommentInput = {
    content: {
      type: ''
    },
    contentText: '',
    parentId: v4()
  };

  const post = await generateForumPost({
    spaceId,
    userId,
    categoryId
  });

  const postComment = await generatePostComment({
    ...commentInput,
    postId: post.id,
    userId
  });

  return {
    comment: postComment,
    post
  };
}

export async function generateForumPost({
  categoryId,
  userId,
  spaceId,
  path = `post-${v4()}`,
  title = 'Test post',
  content,
  contentText,
  isDraft
}: {
  categoryId?: string;
  userId: string;
  spaceId: string;
  path?: string;
  title?: string;
  content?: any;
  contentText?: string;
  isDraft?: boolean;
}) {
  if (!categoryId) {
    const category = await generatePostCategory({ spaceId });
    categoryId = category.id;
  }
  return prisma.post.create({
    data: {
      isDraft,
      title,
      path,
      contentText: contentText ?? '',
      content: content ?? {
        type: 'doc',
        content: []
      },
      space: {
        connect: {
          id: spaceId
        }
      },
      author: {
        connect: {
          id: userId
        }
      },
      category: {
        connect: {
          id: categoryId
        }
      }
    }
  });
}
export async function generatePostComment({
  content,
  contentText,
  parentId,
  postId,
  userId
}: CreatePostCommentInput & {
  postId: string;
  userId: string;
}): Promise<PostComment> {
  const post = await prisma.post.findUniqueOrThrow({
    where: { id: postId },
    include: {
      category: true
    }
  });

  const comment = await prisma.postComment.create({
    data: {
      content,
      contentText: contentText.trim(),
      parentId,
      user: {
        connect: {
          id: userId
        }
      },
      post: {
        connect: {
          id: postId
        }
      }
    }
  });

  return comment;
}
export async function generateForumPosts({
  categoryId,
  count,
  spaceId,
  createdBy,
  content = { type: 'doc', content: [] },
  contentText = '',
  title,
  isDraft,
  withImageRatio = 30
}: {
  isDraft?: boolean;
  spaceId: string;
  categoryId?: string;
  createdBy: string;
  count: number;
  content?: any;
  contentText?: string;
  title?: string;
  withImageRatio?: number;
}): Promise<Post[]> {
  const postCreateInputs: Prisma.PostCreateManyInput[] = [];

  if (!categoryId) {
    const category = await prisma.postCategory.findFirst({
      where: {
        spaceId
      }
    });
    if (!category) {
      const newCategory = await generatePostCategory({ spaceId });
      categoryId = newCategory.id;
    } else {
      categoryId = category.id;
    }
  }

  // Start creating the posts 3 days ago
  let createdAt = Date.now() - 1000 * 60 * 60 * 24 * 30;

  for (let i = 0; i < count; i++) {
    const postDate = new Date(createdAt);

    postCreateInputs.push({
      id: v4(),
      spaceId,
      categoryId,
      contentText,
      content,
      title: `${title ?? 'Post'} ${i}`,
      createdBy,
      path: `path-${v4()}`,
      createdAt: postDate,
      updatedAt: postDate,
      isDraft
    });

    // Space posts apart by 30 minutes
    createdAt += 1000 * 60 * 30;
  }

  await prisma.post.createMany({ data: postCreateInputs });

  const posts = await prisma.post.findMany({
    where: {
      id: {
        in: postCreateInputs.map((post) => post.id as string)
      }
    }
  });
  return posts;
}
