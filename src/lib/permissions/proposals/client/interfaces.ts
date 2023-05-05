import type { PermissionCompute, PermissionToDelete, Resource, SpaceResourcesRequest } from '../../interfaces';
import type {
  AssignedProposalCategoryPermission,
  ProposalCategoryPermissionAssignment,
  ProposalCategoryPermissionFlags,
  ProposalCategoryWithPermissions,
  ProposalPermissionFlags
} from '../interfaces';

export type BaseProposalPermissionsClient = {
  computeProposalPermissions: (request: PermissionCompute) => Promise<ProposalPermissionFlags>;
  computeProposalCategoryPermissions: (request: PermissionCompute) => Promise<ProposalCategoryPermissionFlags>;
  getProposalCategories: (request: SpaceResourcesRequest) => Promise<ProposalCategoryWithPermissions[]>;
};
// eslint-disable-next-line @typescript-eslint/ban-types
export type PremiumProposalPermissionsClient = BaseProposalPermissionsClient & {
  assignDefaultProposalCategoryPermissions: (proposalCategory: Resource) => Promise<void>;
  upsertProposalCategoryPermission: (
    assignment: ProposalCategoryPermissionAssignment
  ) => Promise<AssignedProposalCategoryPermission>;
  deleteProposalCategoryPermission: (permission: PermissionToDelete) => Promise<void>;
  getProposalCategoryPermissions: (request: PermissionCompute) => Promise<AssignedProposalCategoryPermission[]>;
};
