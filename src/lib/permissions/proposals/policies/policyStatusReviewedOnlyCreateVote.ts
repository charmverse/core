import type { ProposalOperation } from '@prisma/client';

import { uniqueValues } from '../../../utilities/array';
import { typedKeys } from '../../../utilities/objects';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyDependencies, ProposalPolicyInput } from './interfaces';

const baseOperations: ProposalOperation[] = ['view', 'comment'];

const allowedAuthorOperations: ProposalOperation[] = [
  ...baseOperations,
  'create_vote',
  'delete',
  'make_public',
  'archive',
  'unarchive'
];
const allowedAdminOperations: ProposalOperation[] = [...allowedAuthorOperations, 'edit'];
const allowedReviewerOperations: ProposalOperation[] = [...baseOperations, 'create_vote'];
const allowedSpaceWideProposalPermissions: ProposalOperation[] = [...baseOperations, 'delete', 'archive', 'unarchive'];

export function injectPolicyStatusReviewedOnlyCreateVote({ isProposalReviewer }: ProposalPolicyDependencies) {
  return async function policyStatusReviewedOnlyCreateVote({
    resource,
    flags,
    userId,
    isAdmin,
    preComputedSpacePermissionFlags
  }: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
    const newPermissions = { ...flags };

    if (resource.status !== 'reviewed') {
      return newPermissions;
    }

    if (isAdmin) {
      typedKeys(flags).forEach((op) => {
        if (!allowedAdminOperations.includes(op)) {
          newPermissions[op] = false;
        }
      });
      return newPermissions;
    }

    const operations: ProposalOperation[] = [...baseOperations];

    if (isProposalAuthor({ proposal: resource, userId })) {
      operations.push(...allowedAuthorOperations);
    }

    if (await isProposalReviewer({ proposal: resource, userId })) {
      operations.push(...allowedReviewerOperations);
    }

    if (preComputedSpacePermissionFlags?.deleteAnyProposal) {
      operations.push(...allowedSpaceWideProposalPermissions);
    }

    const allowedOperations = uniqueValues(operations);

    typedKeys(flags).forEach((flag) => {
      if (!allowedOperations.includes(flag)) {
        newPermissions[flag] = false;
      }
    });

    return newPermissions;
  };
}
