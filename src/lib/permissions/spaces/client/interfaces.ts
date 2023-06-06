import type { Space } from '@prisma/client';

import type { BountyWithDetails } from '../../../bounties/interfaces';
import type { PermissionCompute, SpaceResourcesRequest } from '../../core/interfaces';
import type { PublicBountyToggle, SpaceDefaultPublicPageToggle, SpacePermissionFlags } from '../interfaces';

export type BaseSpacePermissionsClient = {
  computeSpacePermissions: (request: PermissionCompute) => Promise<SpacePermissionFlags>;

  listAvailableBounties: (request: SpaceResourcesRequest) => Promise<BountyWithDetails[]>;
};
export type PremiumSpacePermissionsClient = BaseSpacePermissionsClient & {
  toggleSpaceDefaultPublicPage: (request: SpaceDefaultPublicPageToggle) => Promise<Space>;
  togglePublicBounties: (request: PublicBountyToggle) => Promise<Space>;
};
