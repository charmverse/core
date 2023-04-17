import fetch from '../../../../adapters/http/fetch.server';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type {
  AssignedPostCategoryPermission,
  MutatedPostSearch,
  PermissionCompute,
  PostCategoryPermissionFlags,
  PostPermissionFlags,
  PostSearchToMutate
} from '../../interfaces';

import type { PremiumForumPermissionsClient } from './interfaces';

export class ForumPermissionsHttpClient extends AbstractPermissionsApiClient implements PremiumForumPermissionsClient {
  private prefix = `/api/forum`;

  // eslint-disable-next-line no-useless-constructor
  constructor(params: PermissionsApiClientConstructor) {
    super(params);
  }

  computePostPermissions(request: PermissionCompute): Promise<PostPermissionFlags> {
    return fetch(`${this.baseUrl}${this.prefix}/compute-post-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  computePostCategoryPermissions(request: PermissionCompute): Promise<PostCategoryPermissionFlags> {
    return fetch(`${this.baseUrl}/api/forum/compute-post-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  assignDefaultPostCategoryPermissions(): Promise<void> {
    throw new Error();
  }

  upsertPostCategoryPermission(): Promise<AssignedPostCategoryPermission> {
    throw new Error();
  }

  deletePostCategoryPermission(): Promise<void> {
    throw new Error();
  }

  mutatePostCategorySearch(search: PostSearchToMutate): Promise<MutatedPostSearch> {
    throw new Error();
  }
}
