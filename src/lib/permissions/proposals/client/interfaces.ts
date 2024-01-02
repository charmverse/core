import type { ListProposalsRequest } from '../../../proposals/interfaces';
import type { PermissionCompute } from '../../core/interfaces';
import type { ProposalPermissionFlags, ProposalPermissionsSwitch } from '../interfaces';

// eslint-disable-next-line @typescript-eslint/ban-types
export type BaseProposalPermissionsClient = {};
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
