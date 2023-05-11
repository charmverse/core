import type { ProposalOperation } from '@prisma/client';

import { typedKeys } from '../../../utilities/objects';
import { AvailableProposalPermissions } from '../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../interfaces';
import { isProposalAuthor } from '../isProposalAuthor';

import type { ProposalPolicyDependencies, ProposalPolicyInput } from './interfaces';

export function injectPolicyStatusDraftNotViewable({ isProposalReviewer }: ProposalPolicyDependencies) {
  return async function policyStatusDraftNotViewable({
    resource,
    flags,
    userId,
    isAdmin
  }: ProposalPolicyInput): Promise<ProposalPermissionFlags> {
    const newPermissions = { ...flags };

    if (resource.status !== 'draft') {
      return newPermissions;
    }

    const allowedAuthorOperations: ProposalOperation[] = ['view', 'edit', 'delete', 'comment', 'make_public'];
    const allowedAdminOperations: ProposalOperation[] = ['view', 'delete', 'comment', 'make_public'];

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

    const isReviewer = await isProposalReviewer({ proposal: resource, userId });

    if (isReviewer) {
      // At most allow a non author to view the proposal
      return { ...new AvailableProposalPermissions().empty, view: newPermissions.view === true };
    }

    return new AvailableProposalPermissions().empty;
  };
}
