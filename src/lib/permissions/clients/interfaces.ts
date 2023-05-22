import type { BaseForumPermissionsClient, PremiumForumPermissionsClient } from '../forums/client/interfaces';
import type { BasePagePermissionsClient, PremiumPagePermissionsClient } from '../pages/client/interfaces';
import type { BaseProposalPermissionsClient, PremiumProposalPermissionsClient } from '../proposals/client/interfaces';
import type { BaseSpacePermissionsClient, PremiumSpacePermissionsClient } from '../spaces/client/interfaces';

export type PermissionsClient = {
  forum: BaseForumPermissionsClient;
  proposals: BaseProposalPermissionsClient;
  pages: BasePagePermissionsClient;
  spaces: BaseSpacePermissionsClient;
};

export type PremiumPermissionsClient = {
  forum: PremiumForumPermissionsClient;
  proposals: PremiumProposalPermissionsClient;
  pages: PremiumPagePermissionsClient;
  spaces: PremiumSpacePermissionsClient;
};

export type PermissionsApiClientConstructor = {
  baseUrl: string;
  authKey: string;
};

export * from '../forums/client/interfaces';
