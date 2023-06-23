import { AvailablePostPermissions } from '../availablePostPermissions.class';
import type { PostPermissionFlags } from '../interfaces';

import type { PostPolicyInput } from './interfaces';

export async function policyConvertedToProposal({
  resource,
  flags,
  isAdmin
}: PostPolicyInput): Promise<PostPermissionFlags> {
  if (!resource.proposalId || isAdmin) {
    return flags;
  }

  const emptyPermissions = new AvailablePostPermissions().empty;

  return {
    ...emptyPermissions,
    view_post: flags.view_post === true
  };
}
