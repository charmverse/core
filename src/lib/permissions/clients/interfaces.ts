import type { BaseForumPermissionsClient, PremiumForumPermissionsClient } from '../forums/client/interfaces';

export type PermissionsClient = {
  forum: BaseForumPermissionsClient;
};

export type PremiumPermissionsClient = {
  forum: PremiumForumPermissionsClient;
};

export type PermissionsApiClientConstructor = {
  baseUrl: string;
  authKey: string;
};

export * from '../forums/client/interfaces';
