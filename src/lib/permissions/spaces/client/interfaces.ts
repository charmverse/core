import type { Space } from '@prisma/client';

import type { PermissionCompute } from '../../core/interfaces';
import type { PublicBountyToggle, SpaceDefaultPublicPageToggle, SpacePermissionFlags } from '../interfaces';

export type BaseSpacePermissionsClient = {
  computeSpacePermissions: (request: PermissionCompute) => Promise<SpacePermissionFlags>;
};
export type PremiumSpacePermissionsClient = BaseSpacePermissionsClient & {
  toggleSpaceDefaultPublicPage: (request: SpaceDefaultPublicPageToggle) => Promise<Space>;
  togglePublicBounties: (request: PublicBountyToggle) => Promise<Space>;
};
