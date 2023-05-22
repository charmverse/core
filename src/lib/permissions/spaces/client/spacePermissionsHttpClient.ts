import type { Space } from '@prisma/client';
import { GET, POST } from 'adapters/http';
import type { PermissionCompute } from 'lib/permissions/core/interfaces';

import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PublicBountyToggle, SpaceDefaultPublicPageToggle, SpacePermissionFlags } from '../interfaces';

import type { PremiumSpacePermissionsClient } from './interfaces';

export class SpacePermissionsHttpClient extends AbstractPermissionsApiClient implements PremiumSpacePermissionsClient {
  private get prefix() {
    return `${this.baseUrl}/api/spaces`;
  }

  computeSpacePermissions(request: PermissionCompute): Promise<SpacePermissionFlags> {
    return GET(`${this.prefix}/compute-space-permissions`, request);
  }

  toggleSpaceDefaultPublicPage(request: SpaceDefaultPublicPageToggle): Promise<Space> {
    return POST(`${this.prefix}/toggle-default-public-page`, request);
  }

  togglePublicBounties(request: PublicBountyToggle): Promise<Space> {
    return POST(`${this.prefix}/toggle-public-bounties`, request);
  }
}
