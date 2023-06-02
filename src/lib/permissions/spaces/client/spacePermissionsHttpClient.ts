import type { Space } from '@prisma/client';

import { GET, POST } from '../../../../adapters/http';
import type { BountyWithDetails } from '../../../bounties/interfaces';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionCompute, SpaceResourcesRequest } from '../../core/interfaces';
import type { PublicBountyToggle, SpaceDefaultPublicPageToggle, SpacePermissionFlags } from '../interfaces';

import type { PremiumSpacePermissionsClient } from './interfaces';

export class SpacePermissionsHttpClient extends AbstractPermissionsApiClient implements PremiumSpacePermissionsClient {
  private get prefix() {
    return `${this.baseUrl}/api/spaces`;
  }

  computeSpacePermissions(request: PermissionCompute): Promise<SpacePermissionFlags> {
    return GET(`${this.prefix}/compute-space-permissions`, request);
  }

  listAvailableBounties(request: SpaceResourcesRequest): Promise<BountyWithDetails[]> {
    return GET(`${this.prefix}/list-available-bounties`, request);
  }

  toggleSpaceDefaultPublicPage(request: SpaceDefaultPublicPageToggle): Promise<Space> {
    return POST(`${this.prefix}/toggle-default-public-page`, request, {
      headers: this.jsonHeaders
    });
  }

  togglePublicBounties(request: PublicBountyToggle): Promise<Space> {
    return POST(`${this.prefix}/toggle-public-bounties`, request, {
      headers: this.jsonHeaders
    });
  }
}
