import type {
  ListProposalsRequest,
  ProposalWithCommentsAndUsers,
  ProposalWithUsers
} from '../../../proposals/interfaces';
import type { PermissionCompute, PermissionResource, Resource, SpaceResourcesRequest } from '../../core/interfaces';
import type {
  AssignedProposalCategoryPermission,
  ProposalCategoryPermissionAssignment,
  ProposalCategoryPermissionFlags,
  ProposalCategoryWithPermissions,
  ProposalPermissionFlags,
  ProposalReviewerPool
} from '../interfaces';
import type { ProposalFlowPermissionFlags } from '../proposalFlowFlags';

export type BaseProposalPermissionsClient = {
  computeProposalPermissions: (request: PermissionCompute) => Promise<ProposalPermissionFlags>;
  computeProposalCategoryPermissions: (request: PermissionCompute) => Promise<ProposalCategoryPermissionFlags>;
  computeProposalFlowPermissions: (request: PermissionCompute) => Promise<ProposalFlowPermissionFlags>;
  getAccessibleProposalCategories: (request: SpaceResourcesRequest) => Promise<ProposalCategoryWithPermissions[]>;
  getAccessibleProposals: (request: ListProposalsRequest) => Promise<ProposalWithUsers[]>;
  getAccessibleProposalIds: (request: ListProposalsRequest) => Promise<string[]>;
  getProposalReviewerPool: (request: Resource) => Promise<ProposalReviewerPool>;
};
// eslint-disable-next-line @typescript-eslint/ban-types
export type PremiumProposalPermissionsClient = BaseProposalPermissionsClient & {
  computeBaseProposalPermissions: (request: PermissionCompute) => Promise<ProposalPermissionFlags>;
  assignDefaultProposalCategoryPermissions: (proposalCategory: Resource) => Promise<void>;
  upsertProposalCategoryPermission: (
    assignment: ProposalCategoryPermissionAssignment
  ) => Promise<AssignedProposalCategoryPermission>;
  deleteProposalCategoryPermission: (permission: PermissionResource) => Promise<void>;
  getProposalCategoryPermissions: (request: PermissionCompute) => Promise<AssignedProposalCategoryPermission[]>;
};
