import type { Post, PostUpDownVote } from '@prisma/client';

export type ForumPostWithVotes = Post & { upDownVotes: Pick<PostUpDownVote, 'upvoted' | 'createdBy'> };
