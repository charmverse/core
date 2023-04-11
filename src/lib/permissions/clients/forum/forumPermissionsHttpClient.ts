import fetch from '../../../../adapters/http/fetch.server';
import type { PermissionCompute } from '../../interfaces';
import { AbstractPermissionsApiClient } from '../abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../interfaces';

import type { ForumPermissionsClient, PostCategoryPermissionFlags, PostPermissionFlags } from './forumInterfaces';

export class ForumPermissionsHttpClient extends AbstractPermissionsApiClient implements ForumPermissionsClient {
  // eslint-disable-next-line no-useless-constructor
  constructor(params: PermissionsApiClientConstructor) {
    super(params);
  }

  computePostPermissions(request: PermissionCompute): Promise<PostPermissionFlags> {
    return fetch(`${this.baseUrl}/permissions/forum/conpute-post-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  computePostCategoryPermissions(request: PermissionCompute): Promise<PostCategoryPermissionFlags> {
    return fetch(`${this.baseUrl}/permissions/forum/conpute-post-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }
}
