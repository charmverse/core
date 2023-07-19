import type { ProposalOperation } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import { AvailableProposalPermissions } from '../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyInput } from './interfaces';

export async function policyStatusDraftNotViewable({
  resource,
  flags,
  userId,
  isAdmin,
  preComputedSpacePermissionFlags
}: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
  if (resource.status !== 'draft') {
    return flags;
  }

  const newPermissions = { ...flags };

  const allowedAuthorOperations: ProposalOperation[] = [
    'view',
    'edit',
    'delete',
    'comment',
    'make_public',
    'archive',
    'unarchive'
  ];

  if (isProposalAuthor({ proposal: resource, userId }) || isAdmin) {
    typedKeys(flags).forEach((flag) => {
      if (!allowedAuthorOperations.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
    return newPermissions;
  } else if (preComputedSpacePermissionFlags?.deleteAnyProposal) {
    const allowedSpaceWideProposalPermissions: ProposalOperation[] = ['delete', 'view', 'archive', 'unarchive'];
    typedKeys(flags).forEach((flag) => {
      if (!allowedSpaceWideProposalPermissions.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
    return newPermissions;
  }

  return new AvailableProposalPermissions().empty;
}
