import type { ProposalPolicyDependencies } from './interfaces';
import { policyStatusDiscussionEditableCommentable } from './policyStatusDiscussionEditableCommentable';
import { policyStatusDraftNotViewable } from './policyStatusDraftNotViewable';
import { injectPolicyStatusReviewCommentable } from './policyStatusReviewCommentable';
import { policyStatusReviewedOnlyCreateVote } from './policyStatusReviewedOnlyCreateVote';
import { policyStatusVoteActiveOnlyVotable } from './policyStatusVoteActiveOnlyVotable';
import { policyStatusVoteClosedViewOnly } from './policyStatusVoteClosedViewOnly';

/**
 * Some policies depend on isProposalReviewer, which requires also looking up roles in private version. Consumer can pass correct version of isProposalReviewe here
 */
export function getDefaultProposalPermissionPolicies(deps: ProposalPolicyDependencies) {
  return [
    policyStatusDraftNotViewable,
    policyStatusDiscussionEditableCommentable,
    injectPolicyStatusReviewCommentable(deps),
    policyStatusReviewedOnlyCreateVote,
    policyStatusVoteActiveOnlyVotable,
    policyStatusVoteClosedViewOnly
  ];
}

export * from './interfaces';
