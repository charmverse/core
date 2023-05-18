import type { PostOperation } from '../../../../prisma';
import { typedKeys } from '../../../utilities/objects';
import type { PostPermissionFlags } from '../interfaces';

import type { PostPolicyInput } from './interfaces';

export async function policyConvertedToProposal({ resource, flags }: PostPolicyInput): Promise<PostPermissionFlags> {
  const newPermissions = { ...flags };

  if (!resource.proposalId) {
    return newPermissions;
  }

  const allowedOperations: PostOperation[] = ['view_post', 'delete_post'];

  typedKeys(flags).forEach((flag) => {
    if (!allowedOperations.includes(flag)) {
      newPermissions[flag] = false;
    }
  });

  return newPermissions;
}
