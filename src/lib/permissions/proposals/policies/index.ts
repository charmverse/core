import { prisma } from '../../../../prisma-client';
import { InvalidInputError, ProposalNotFoundError } from '../../../errors';
import { isUUID } from '../../../utilities/strings';
import type { Resource } from '../../core/interfaces';

import type { ProposalPolicyDependencies, ProposalResource } from './interfaces';
import { policyArchivedViewOnly } from './policyArchivedViewOnly';
import { policyStatusDiscussionEditableCommentable } from './policyStatusDiscussionEditableCommentable';
import { policyStatusDraftNotViewable } from './policyStatusDraftNotViewable';
import { injectPolicyStatusEvaluationActiveCommentable } from './policyStatusEvaluationActiveCommentable';
import { policyStatusEvaluationClosedViewOnly } from './policyStatusEvaluationClosedViewOnly';
import { injectPolicyStatusReviewCommentable } from './policyStatusReviewCommentable';
import { injectPolicyStatusReviewedOnlyCreateVote } from './policyStatusReviewedOnlyCreateVote';
import { policyStatusVoteActiveOnlyVotable } from './policyStatusVoteActiveOnlyVotable';
import { policyStatusVoteClosedViewOnly } from './policyStatusVoteClosedViewOnly';

export function proposalResourceSelect() {
  return {
    id: true,
    status: true,
    categoryId: true,
    spaceId: true,
    createdBy: true,
    authors: true,
    reviewers: true,
    archived: true,
    evaluations: {
      include: {
        permissions: true,
        reviewers: true
      }
    },
    space: {
      select: {
        publicProposals: true
      }
    }
  };
}

export async function proposalResolver({ resourceId }: Resource): Promise<ProposalResource> {
  if (!isUUID(resourceId)) {
    throw new InvalidInputError(`Invalid resource ID provided. Must be a UUID`);
  }
  const proposal = await prisma.proposal.findUnique({
    where: { id: resourceId },
    select: proposalResourceSelect()
  });

  if (!proposal) {
    throw new ProposalNotFoundError(resourceId);
  }
  return proposal;
}

/**
 * Some policies depend on isProposalReviewer, which requires also looking up roles in private version. Consumer can pass correct version of isProposalReviewe here
 */
export function getDefaultProposalPermissionPolicies(deps: ProposalPolicyDependencies) {
  return [
    policyStatusDraftNotViewable,
    policyStatusDiscussionEditableCommentable,
    injectPolicyStatusReviewCommentable(deps),
    injectPolicyStatusReviewedOnlyCreateVote(deps),
    policyStatusVoteActiveOnlyVotable,
    policyStatusVoteClosedViewOnly,
    injectPolicyStatusEvaluationActiveCommentable(deps),
    policyStatusEvaluationClosedViewOnly,
    policyArchivedViewOnly
  ];
}
