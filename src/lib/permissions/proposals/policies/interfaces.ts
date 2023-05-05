import type { ProposalWithUsers } from '../../../proposals/interfaces';
import type { PermissionFilteringPolicyFnInput } from '../../core/policies';
import type { IsProposalReviewerFn, ProposalPermissionFlags } from '../interfaces';

export type ProposalResource = Pick<
  ProposalWithUsers,
  'id' | 'createdBy' | 'status' | 'categoryId' | 'spaceId' | 'spaceId' | 'authors' | 'reviewers'
>;

export type ProposalPolicyInput = PermissionFilteringPolicyFnInput<ProposalResource, ProposalPermissionFlags>;
export type ProposalPolicyDependencies = {
  isProposalReviewer: IsProposalReviewerFn;
};
