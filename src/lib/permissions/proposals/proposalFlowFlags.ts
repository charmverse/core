import { ProposalStatus } from '@prisma/client';

import type { ProposalWithUsers } from '../../proposals/interfaces';
import { typedKeys } from '../../utilities/objects';
import { BasePermissions } from '../core/basePermissions.class';
import type { PermissionCompute } from '../core/interfaces';
import { hasAccessToSpace } from '../hasAccessToSpace';

import type { IsProposalReviewerFn, ProposalPermissionFlags } from './interfaces';
import { isProposalAuthor } from './isProposalAuthor';

export type ProposalFlowPermissionFlags = Record<ProposalStatus, boolean>;

export type GetFlagsInput = { userId: string; proposal: ProposalWithUsers };

export class TransitionFlags extends BasePermissions<ProposalStatus> {
  constructor() {
    super({ allowedOperations: typedKeys(ProposalStatus) });
  }
}

export type GetFlagFilterDependencies = {
  isProposalReviewer: IsProposalReviewerFn;
  computeProposalPermissions: (compute: PermissionCompute) => Promise<ProposalPermissionFlags>;
  countReviewers: (data: { proposal: ProposalWithUsers }) => number;
};

function withDepsDraftProposal({ countReviewers }: GetFlagFilterDependencies) {
  return async function draftProposal({ proposal, userId }: GetFlagsInput): Promise<ProposalFlowPermissionFlags> {
    const flags = new TransitionFlags();
    const { isAdmin } = await hasAccessToSpace({ spaceId: proposal.spaceId, userId });

    if (isProposalAuthor({ proposal, userId }) || isAdmin) {
      if (countReviewers({ proposal })) {
        flags.addPermissions(['discussion']);
      }
    }
    return flags.operationFlags;
  };
}

function withDepsDiscussionProposal({ countReviewers, isProposalReviewer }: GetFlagFilterDependencies) {
  return async function discussionProposal({ proposal, userId }: GetFlagsInput): Promise<ProposalFlowPermissionFlags> {
    const flags = new TransitionFlags();
    if (
      isProposalAuthor({ proposal, userId }) ||
      (await hasAccessToSpace({ spaceId: proposal.spaceId, userId })).isAdmin
    ) {
      flags.addPermissions(['draft']);

      if (countReviewers({ proposal }) > 0) {
        flags.addPermissions([proposal.evaluationType === 'vote' ? 'review' : 'evaluation_active']);
      }
    } else if ((await isProposalReviewer({ proposal, userId })) === true) {
      flags.addPermissions([proposal.evaluationType === 'vote' ? 'review' : 'evaluation_active']);
    }

    return flags.operationFlags;
  };
}

function withDepsInReviewProposal({ isProposalReviewer }: GetFlagFilterDependencies) {
  // Currently coupled to proposal permissions for review action
  // In future, when reviewing action, and review status transition are decoupled, this will need to be updated
  return async function inReviewProposal({ proposal, userId }: GetFlagsInput): Promise<ProposalFlowPermissionFlags> {
    const flags = new TransitionFlags();

    const isReviewer = await isProposalReviewer({ proposal, userId });

    const isAdmin = (
      await hasAccessToSpace({
        spaceId: proposal.spaceId,
        userId
      })
    ).isAdmin;

    if (isAdmin) {
      flags.addPermissions(['discussion', 'reviewed']);
    }

    if (isProposalAuthor({ proposal, userId })) {
      flags.addPermissions(['discussion']);
    } else if (isReviewer) {
      flags.addPermissions(['reviewed', 'discussion']);
    }
    return flags.operationFlags;
  };
}

function withDepsReviewedProposal({ computeProposalPermissions, isProposalReviewer }: GetFlagFilterDependencies) {
  // Currently coupled to proposal permissions for create_vote action
  // In future, when create_vote action, and vote_active status transition are decoupled, this will need to be updated
  return async function reviewedProposal({ proposal, userId }: GetFlagsInput): Promise<ProposalFlowPermissionFlags> {
    const flags = new TransitionFlags();

    const isAdmin = (await hasAccessToSpace({ spaceId: proposal.spaceId, userId })).spaceRole?.isAdmin;

    if (isAdmin) {
      flags.addPermissions(['review', 'vote_active']);
    } else if (isProposalAuthor({ proposal, userId })) flags.addPermissions(['vote_active']);
    if ((await isProposalReviewer({ proposal, userId })) === true) {
      flags.addPermissions(['review', 'vote_active']);
    }

    return flags.operationFlags;
  };
}

function withDepsEvaluationActiveProposal({ isProposalReviewer }: GetFlagFilterDependencies) {
  return async function evaluationActiveProposal({
    proposal,
    userId
  }: GetFlagsInput): Promise<ProposalFlowPermissionFlags> {
    const flags = new TransitionFlags();
    const { spaceRole } = await hasAccessToSpace({
      spaceId: proposal.spaceId,
      userId
    });

    if (spaceRole?.isAdmin) {
      flags.addPermissions(['evaluation_closed', 'discussion']);
    } else if (isProposalAuthor({ proposal, userId })) {
      flags.addPermissions(['discussion']);
    } else if ((await isProposalReviewer({ proposal, userId })) === true) {
      flags.addPermissions(['evaluation_closed', 'discussion']);
    }

    return flags.operationFlags;
  };
}

function withDepsEvaluationClosedProposal({ isProposalReviewer }: GetFlagFilterDependencies) {
  return async function evaluationActiveProposal({
    proposal,
    userId
  }: GetFlagsInput): Promise<ProposalFlowPermissionFlags> {
    const flags = new TransitionFlags();
    const { spaceRole } = await hasAccessToSpace({
      spaceId: proposal.spaceId,
      userId
    });

    if (spaceRole?.isAdmin || (await isProposalReviewer({ proposal, userId })) === true) {
      flags.addPermissions(['evaluation_active']);
    }

    return flags.operationFlags;
  };
}

export function getProposalFlagFilters(
  deps: GetFlagFilterDependencies
): Record<ProposalStatus, (args: GetFlagsInput) => Promise<ProposalFlowPermissionFlags>> {
  return {
    [ProposalStatus.draft]: withDepsDraftProposal(deps),
    [ProposalStatus.discussion]: withDepsDiscussionProposal(deps),
    [ProposalStatus.review]: withDepsInReviewProposal(deps),
    [ProposalStatus.reviewed]: withDepsReviewedProposal(deps),
    [ProposalStatus.vote_active]: () => Promise.resolve(new TransitionFlags().empty),
    [ProposalStatus.vote_closed]: () => Promise.resolve(new TransitionFlags().empty),
    [ProposalStatus.evaluation_active]: withDepsEvaluationActiveProposal(deps),
    [ProposalStatus.evaluation_closed]: withDepsEvaluationClosedProposal(deps)
  };
}
