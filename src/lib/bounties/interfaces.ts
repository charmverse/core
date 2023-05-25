import type { Application, Bounty } from '@prisma/client';

import type { PageMetaWithPermissions } from '../pages/interfaces';

export type BountyWithDetails = Bounty & {
  applications: Application[];
  page: PageMetaWithPermissions;
};
