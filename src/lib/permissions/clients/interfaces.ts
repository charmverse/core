import type { BaseForumPermissionsClient, PremiumForumPermissionsClient } from '../forums/client/interfaces';
import type { BasePagePermissionsClient, PremiumPagePermissionsClient } from '../pages/client/interfaces';
import type { BaseProposalPermissionsClient, PremiumProposalPermissionsClient } from '../proposals/client/interfaces';

export type PermissionsClient = {
  forum: BaseForumPermissionsClient;
  proposals: BaseProposalPermissionsClient;
  pages: BasePagePermissionsClient;
};

export type PremiumPermissionsClient = {
  forum: PremiumForumPermissionsClient;
  proposals: PremiumProposalPermissionsClient;
  pages: PremiumPagePermissionsClient;
};

export type PermissionsApiClientConstructor = {
  baseUrl: string;
  authKey: string;
};

export * from '../forums/client/interfaces';
