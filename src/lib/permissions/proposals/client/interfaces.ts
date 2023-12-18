import type { ListProposalsRequest } from '../../../proposals/interfaces';
import type { PermissionCompute, PermissionResource, Resource, SpaceResourcesRequest } from '../../core/interfaces';
import type {
  AssignedProposalCategoryPermission,
  ProposalCategoryPermissionAssignment,
  ProposalCategoryPermissionFlags,
  ProposalCategoryWithPermissions,
  ProposalPermissionFlags,
  ProposalPermissionsSwitch,
  ProposalReviewerPool
} from '../interfaces';
import type { ProposalFlowPermissionFlags } from '../proposalFlowFlags';

export type BaseProposalPermissionsClient = {
  computeProposalPermissions: (
    request: PermissionCompute & ProposalPermissionsSwitch
  ) => Promise<ProposalPermissionFlags>;
  computeProposalCategoryPermissions: (request: PermissionCompute) => Promise<ProposalCategoryPermissionFlags>;
  computeProposalFlowPermissions: (request: PermissionCompute) => Promise<ProposalFlowPermissionFlags>;
  getAccessibleProposalCategories: (request: SpaceResourcesRequest) => Promise<ProposalCategoryWithPermissions[]>;
  getProposalReviewerPool: (request: Resource) => Promise<ProposalReviewerPool>;
};
// eslint-disable-next-line @typescript-eslint/ban-types
export type PremiumProposalPermissionsClient = BaseProposalPermissionsClient & {
  // This will be the new method used for proposals with evaluation step
  getAccessibleProposalIds: (request: ListProposalsRequest & ProposalPermissionsSwitch) => Promise<string[]>;
  computeBaseProposalPermissions: (request: PermissionCompute) => Promise<ProposalPermissionFlags>;
  assignDefaultProposalCategoryPermissions: (proposalCategory: Resource) => Promise<void>;
  upsertProposalCategoryPermission: (
    assignment: ProposalCategoryPermissionAssignment
  ) => Promise<AssignedProposalCategoryPermission>;
  deleteProposalCategoryPermission: (permission: PermissionResource) => Promise<void>;
  getProposalCategoryPermissions: (request: PermissionCompute) => Promise<AssignedProposalCategoryPermission[]>;
};
