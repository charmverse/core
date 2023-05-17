import type { Space } from '@prisma/client';

import type { PublicBountyToggle, SpaceDefaultPublicPageToggle } from '../interfaces';

// eslint-disable-next-line @typescript-eslint/ban-types
export type BaseSpacePermissionsClient = {};
export type PremiumSpacePermissionsClient = BaseSpacePermissionsClient & {
  toggleSpaceDefaultPublicPage: (request: SpaceDefaultPublicPageToggle) => Promise<Space>;
  togglePublicBounties: (request: PublicBountyToggle) => Promise<Space>;
};
