import type { ProposalCategoryPermission } from '@prisma/client';

import { getPermissionAssignee } from '../core/getPermissionAssignee';
import type { TargetPermissionGroup } from '../interfaces';

import type { AssignableProposalCategoryPermissionGroups, AssignedProposalCategoryPermission } from './interfaces';

export function mapProposalCategoryPermissionToAssignee(
  proposalCategoryPermission: ProposalCategoryPermission
): AssignedProposalCategoryPermission {
  return {
    id: proposalCategoryPermission.id,
    permissionLevel: proposalCategoryPermission.permissionLevel,
    proposalCategoryId: proposalCategoryPermission.proposalCategoryId,
    assignee: getPermissionAssignee(
      proposalCategoryPermission
    ) as TargetPermissionGroup<AssignableProposalCategoryPermissionGroups>
  };
}
