import type { ProposalAuthor, ProposalReviewer } from '@prisma/client';
import { ProposalOperation } from '@prisma/client';

import type { ProposalWithUsers } from '../../proposals/interfaces';
import { typedKeys } from '../../utilities/objects';
import type { UserPermissionFlags } from '../core/interfaces';

export type ProposalActors = {
  authors: ProposalAuthor[];
  reviewers: ProposalReviewer[];
};

export const proposalOperations = [...typedKeys(ProposalOperation)] as const;

export type ProposalPermissionFlags = UserPermissionFlags<ProposalOperation>;

/**
 * When returning proposal categories, also pre-compute if a user can add a proposal to that category
 */
export type IsProposalReviewerFnInput = {
  proposal: Pick<ProposalWithUsers, 'id' | 'spaceId' | 'reviewers'>;
  userId?: string;
};
export type IsProposalReviewerFn = (args: IsProposalReviewerFnInput) => Promise<boolean> | boolean;

/**
 * @users - a list of user ids that can be selected to review a proposal
 * @roles - a list of role ids that can be selected to review a proposal
 *
 */
export type ProposalReviewerPool = {
  userIds: string[];
  roleIds: string[];
};
