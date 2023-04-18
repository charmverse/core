import type { PostCategory, PostComment } from '@prisma/client';
import { v4 } from 'uuid';

import { prisma } from '../../db';
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
