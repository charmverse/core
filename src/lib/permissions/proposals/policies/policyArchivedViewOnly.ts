import type { ProposalOperation } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyInput } from './interfaces';

export async function policyArchivedViewOnly({
  resource,
  isAdmin,
  flags,
  userId,
  preComputedSpacePermissionFlags
}: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
  if (!resource.archived) {
    return flags;
  }

  const newPermissions = { ...flags };

  const allowedOperations: ProposalOperation[] = ['view'];
  const allowedAuthorOperations: ProposalOperation[] = [
    ...allowedOperations,
    'delete',
    'make_public',
    'archive',
    'unarchive'
  ];
  const allowedAdminOperations: ProposalOperation[] = allowedAuthorOperations;

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
    const allowedSpaceWideProposalPermissions: ProposalOperation[] = ['delete', 'view', 'archive', 'unarchive'];
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
