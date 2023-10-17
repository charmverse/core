import type { Space } from '@prisma/client';

import type { BountyWithDetails } from '../../../bounties/interfaces';
import type { PermissionCompute } from '../../core/interfaces';
import type { PublicBountyToggle, SpaceDefaultPublicPageToggle, SpacePermissionFlags } from '../interfaces';

export type BaseSpacePermissionsClient = {
  computeSpacePermissions: (request: PermissionCompute) => Promise<SpacePermissionFlags>;
  listAvailableBounties: (request: SpaceResourcesRequest) => Promise<BountyWithDetails[]>; // TODO: remove this after rewards have replaced bounties in webapp
};
export type PremiumSpacePermissionsClient = BaseSpacePermissionsClient & {
  toggleSpaceDefaultPublicPage: (request: SpaceDefaultPublicPageToggle) => Promise<Space>;
  togglePublicBounties: (request: PublicBountyToggle) => Promise<Space>;
};
