import type { ProposalEvaluation, ProposalEvaluationPermission, ProposalReviewer, Space } from '@prisma/client';

import type { ProposalWithUsers } from '../../../proposals/interfaces';
import type { PermissionFilteringPolicyFnInput } from '../../core/policies';
import type { IsProposalReviewerFn, ProposalPermissionFlags } from '../interfaces';

export type ProposalResource = Pick<
  ProposalWithUsers,
  'id' | 'createdBy' | 'status' | 'categoryId' | 'spaceId' | 'authors' | 'reviewers' | 'archived'
> & {
  space: Pick<Space, 'publicProposals'>;
  evaluations: (ProposalEvaluation & {
    reviewers: ProposalReviewer[];
    permissions: ProposalEvaluationPermission[];
  })[];
};

export type ProposalPolicyInput = PermissionFilteringPolicyFnInput<ProposalResource, ProposalPermissionFlags, true>;
export type ProposalPolicyDependencies = {
  isProposalReviewer: IsProposalReviewerFn;
};
