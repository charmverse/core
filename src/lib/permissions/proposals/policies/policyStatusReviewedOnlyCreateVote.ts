import type { ProposalOperation } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import { AvailableProposalPermissions } from '../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyInput } from './interfaces';

export async function policyStatusReviewedOnlyCreateVote({
  resource,
  flags,
  userId,
  isAdmin
}: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
  const newPermissions = { ...flags };

  if (resource.status !== 'reviewed') {
    return newPermissions;
  }

  const allowedAuthorOperations: ProposalOperation[] = ['view', 'create_vote', 'delete', 'make_public'];
  const allowedAdminOperations: ProposalOperation[] = [...allowedAuthorOperations, 'edit'];

  if (isProposalAuthor({ proposal: resource, userId })) {
    typedKeys(flags).forEach((flag) => {
      if (!allowedAuthorOperations.includes(flag)) {
        newPermissions[flag] = false;
      }
    });
    return newPermissions;
  } else if (isAdmin) {
    typedKeys(flags).forEach((flag) => {
      if (!allowedAdminOperations.includes(flag)) {
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
}
