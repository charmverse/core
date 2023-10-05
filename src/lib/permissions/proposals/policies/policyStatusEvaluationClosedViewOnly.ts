import type { ProposalOperation } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyInput } from './interfaces';

const allowedOperations: ProposalOperation[] = ['view', 'comment'];
const allowedAuthorOperations: ProposalOperation[] = [...allowedOperations, 'make_public', 'archive', 'unarchive'];
const allowedAdminOperations: ProposalOperation[] = [...allowedAuthorOperations, 'delete'];
const allowedSpaceWideProposalPermissions: ProposalOperation[] = ['delete', 'view', 'archive', 'unarchive'];

export async function policyStatusEvaluationClosedViewOnly({
  resource,
  isAdmin,
  flags,
  userId,
  preComputedSpacePermissionFlags
}: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
  if (resource.status !== 'evaluation_closed') {
    return flags;
  }

  const newPermissions = { ...flags };

  if (isAdmin) {
    typedKeys(flags).forEach((flag) => {
      if (!allowedAdminOperations.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
  } else if (isProposalAuthor({ userId, proposal: resource })) {
    typedKeys(flags).forEach((flag) => {
      if (!allowedAuthorOperations.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
  } else if (preComputedSpacePermissionFlags?.deleteAnyProposal) {
    typedKeys(flags).forEach((flag) => {
      if (!allowedSpaceWideProposalPermissions.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
    return newPermissions;
  } else {
    typedKeys(flags).forEach((flag) => {
      if (!allowedOperations.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
  }
  return newPermissions;
}
