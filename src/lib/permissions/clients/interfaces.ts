import type { BaseForumPermissionsClient, PremiumForumPermissionsClient } from '../forums/client/interfaces';
import type { BaseProposalPermissionsClient, PremiumProposalPermissionsClient } from '../proposals/client/interfaces';

export type PermissionsClient = {
  forum: BaseForumPermissionsClient;
  proposals: BaseProposalPermissionsClient;
};

export type PremiumPermissionsClient = {
  forum: PremiumForumPermissionsClient;
  proposals: PremiumProposalPermissionsClient;
};

export type PermissionsApiClientConstructor = {
  baseUrl: string;
  authKey: string;
};

export * from '../forums/client/interfaces';
