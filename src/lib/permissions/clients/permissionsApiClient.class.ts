import { ForumPermissionsHttpClient } from '../forums/client/forumPermissionsHttpClient';
import type { PremiumForumPermissionsClient } from '../forums/client/interfaces';

import type { PermissionsApiClientConstructor, PremiumPermissionsClient } from './interfaces';

export class PermissionsApiClient implements PremiumPermissionsClient {
  forum: PremiumForumPermissionsClient;

  constructor(params: PermissionsApiClientConstructor) {
    this.forum = new ForumPermissionsHttpClient(params);
  }
}
