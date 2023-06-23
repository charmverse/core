import type { Space } from '@prisma/client';
import { prisma } from 'prisma-client';

import { hasAccessToSpace } from '../../hasAccessToSpace';
import { AvailablePagePermissions } from '../availablePagePermissions.class';
import type { PagePermissionFlags } from '../interfaces';

import type { PagePolicyInput } from './interfaces';

export async function policyConvertedToProposal({
  flags,
  resource,
  isAdmin
}: PagePolicyInput): Promise<PagePermissionFlags> {
  if (!resource.convertedProposalId || isAdmin) {
    return flags;
  }

  const emptyPermissions = new AvailablePagePermissions().empty;

  // Only provide the read permission if it exists
  return {
    ...emptyPermissions,
    read: flags.read === true
  };
}
