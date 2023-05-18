import type { Post, PostUpDownVote } from '../../../prisma';

export type ForumPostWithVotes = Post & { upDownVotes: Pick<PostUpDownVote, 'upvoted' | 'createdBy'> };
