import type { ProposalOperation } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import { AvailableProposalPermissions } from '../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyDependencies, ProposalPolicyInput } from './interfaces';

const allowedAuthorOperations: ProposalOperation[] = [
  'view',
  'comment',
  'delete',
  'make_public',
  'archive',
  'unarchive'
];
const allowedAdminOperations: ProposalOperation[] = [...allowedAuthorOperations, 'review', 'edit'];
const allowedReviewerOperations: ProposalOperation[] = ['view', 'comment', 'review'];

export function injectPolicyStatusReviewCommentable({ isProposalReviewer }: ProposalPolicyDependencies) {
  return async function policyStatusReviewCommentable({
    resource,
    flags,
    userId,
    isAdmin,
    spacePermissionFlags
  }: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
    const newPermissions = { ...flags };

    if (resource.status !== 'review') {
      return newPermissions;
    }

    if (isAdmin) {
      typedKeys(flags).forEach((flag) => {
        if (!allowedAdminOperations.includes(flag)) {
          newPermissions[flag] = false;
        }
      });
      return newPermissions;
    } else if (spacePermissionFlags?.deleteAnyProposal) {
      const allowedSpaceWideProposalPermissions: ProposalOperation[] = ['delete', 'view', 'archive', 'unarchive'];
      typedKeys(flags).forEach((flag) => {
        if (!allowedSpaceWideProposalPermissions.includes(flag)) {
          newPermissions[flag] = false;
        }
      });
      return newPermissions;
    }

    const isAuthor = isProposalAuthor({ proposal: resource, userId });
    const isReviewer = await isProposalReviewer({ proposal: resource, userId });

    if (isAuthor && isReviewer) {
      typedKeys(flags).forEach((flag) => {
        if (![...allowedAuthorOperations, ...allowedReviewerOperations].includes(flag)) {
          newPermissions[flag] = false;
        }
      });
      return newPermissions;
    } else if (isAuthor) {
      typedKeys(flags).forEach((flag) => {
        if (!allowedAuthorOperations.includes(flag)) {
          newPermissions[flag] = false;
        }
      });
      return newPermissions;
    } else if (isReviewer) {
      typedKeys(flags).forEach((flag) => {
        if (!allowedReviewerOperations.includes(flag)) {
          newPermissions[flag] = false;
        }
      });
      return newPermissions;
    }

    // At most allow a non author to view the proposal
    return {
      ...new AvailableProposalPermissions().empty,
      view: newPermissions.view === true
    };
  };
}
