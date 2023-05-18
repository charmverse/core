import type { PageOperations } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import type { PagePermissionFlags } from '../interfaces';

import type { PagePolicyInput } from './interfaces';

export async function policyConvertedToProposal({ flags, resource }: PagePolicyInput): Promise<PagePermissionFlags> {
  const newPermissions = { ...flags };

  if (!resource.convertedProposalId) {
    return newPermissions;
  }

  const allowedOperations: PageOperations[] = ['read'];

  typedKeys(flags).forEach((flag) => {
    if (!allowedOperations.includes(flag)) {
      newPermissions[flag] = false;
    }
  });

  return newPermissions;
}
