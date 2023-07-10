import { prisma } from '../../../../prisma-client';
import type { Resource } from '../../core/interfaces';

import type { ProposalPolicyDependencies, ProposalResource } from './interfaces';
import { policyArchivedViewOnly } from './policyArchivedViewOnly';
import { policyStatusDiscussionEditableCommentable } from './policyStatusDiscussionEditableCommentable';
import { policyStatusDraftNotViewable } from './policyStatusDraftNotViewable';
import { injectPolicyStatusReviewCommentable } from './policyStatusReviewCommentable';
import { policyStatusReviewedOnlyCreateVote } from './policyStatusReviewedOnlyCreateVote';
import { policyStatusVoteActiveOnlyVotable } from './policyStatusVoteActiveOnlyVotable';
import { policyStatusVoteClosedViewOnly } from './policyStatusVoteClosedViewOnly';

export function proposalResolver({ resourceId }: Resource): Promise<ProposalResource> {
  return prisma.proposal.findUniqueOrThrow({
    where: { id: resourceId },
    select: {
      id: true,
      status: true,
      categoryId: true,
      spaceId: true,
      createdBy: true,
      authors: true,
      reviewers: true,
      archived: true
    }
  });
}

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
    policyStatusVoteClosedViewOnly,
    policyArchivedViewOnly
  ];
}
