import type { ProposalOperation } from '@prisma/client';

import { uniqueValues } from '../../../utilities/array';
import { typedKeys } from '../../../utilities/objects';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyDependencies, ProposalPolicyInput } from './interfaces';
// Any space member should have access to these permissions (if they are allowed)
const baseOperations: ProposalOperation[] = ['view', 'comment'];

const allowedAuthorOperations: ProposalOperation[] = [
  ...baseOperations,
  'delete',
  'make_public',
  'archive',
  'unarchive'
];
const allowedAdminOperations: ProposalOperation[] = [...allowedAuthorOperations, 'evaluate', 'edit'];
const allowedReviewerOperations: ProposalOperation[] = [...baseOperations, 'evaluate'];
const allowedSpaceWideProposalPermissions: ProposalOperation[] = [...baseOperations, 'delete', 'archive', 'unarchive'];

export function injectPolicyStatusEvaluationActiveCommentable({ isProposalReviewer }: ProposalPolicyDependencies) {
  return async function policyStatusEvaluationActiveCommentable({
    resource,
    flags,
    userId,
    isAdmin,
    preComputedSpacePermissionFlags
  }: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
    if (resource.status !== 'evaluation_active') {
      return flags;
    }

    const newPermissions = { ...flags };

    if (isAdmin) {
      typedKeys(flags).forEach((flag) => {
        if (!allowedAdminOperations.includes(flag)) {
          newPermissions[flag] = false;
        }
      });
      return newPermissions;
    }

    const isAuthor = isProposalAuthor({ proposal: resource, userId });
    const isReviewer = await isProposalReviewer({ proposal: resource, userId });

    const operations = [...baseOperations];

    if (preComputedSpacePermissionFlags?.deleteAnyProposal) {
      operations.push(...allowedSpaceWideProposalPermissions);
    }

    if (isAuthor) {
      operations.push(...allowedAuthorOperations);
    }

    if (isReviewer) {
      operations.push(...allowedReviewerOperations);
    }

    const allowedOperations = uniqueValues(operations);

    typedKeys(flags).forEach((op) => {
      if (!allowedOperations.includes(op)) {
        newPermissions[op] = false;
      }
    });
    return newPermissions;
  };
}
