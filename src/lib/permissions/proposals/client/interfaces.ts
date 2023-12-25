import type { ListProposalsRequest } from '../../../proposals/interfaces';
import type { PermissionCompute, Resource } from '../../core/interfaces';
import type { ProposalPermissionFlags, ProposalPermissionsSwitch, ProposalReviewerPool } from '../interfaces';
import type { ProposalFlowPermissionFlags } from '../proposalFlowFlags';

export type BaseProposalPermissionsClient = {
  computeProposalFlowPermissions: (request: PermissionCompute) => Promise<ProposalFlowPermissionFlags>;
  getProposalReviewerPool: (request: Resource) => Promise<ProposalReviewerPool>;
};
// eslint-disable-next-line @typescript-eslint/ban-types
export type PremiumProposalPermissionsClient = BaseProposalPermissionsClient & {
  computeProposalPermissions: (
    request: PermissionCompute & ProposalPermissionsSwitch
  ) => Promise<ProposalPermissionFlags>;
  // This will be the new method used for proposals with evaluation step
  getAccessibleProposalIds: (request: ListProposalsRequest & ProposalPermissionsSwitch) => Promise<string[]>;
  computeBaseProposalPermissions: (
    request: PermissionCompute & ProposalPermissionsSwitch
  ) => Promise<ProposalPermissionFlags>;
};
