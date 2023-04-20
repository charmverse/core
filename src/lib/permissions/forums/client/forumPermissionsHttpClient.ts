import fetch from '../../../../adapters/http/fetch.server';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type {
  AssignedPostCategoryPermission,
  MutatedPostSearch,
  PermissionCompute,
  PermissionToDelete,
  PostCategoryPermissionFlags,
  PostPermissionFlags,
  PostSearchToMutate,
  Resource
} from '../../interfaces';
import type { CategoriesToFilter, PostCategoryPermissionAssignment, PostCategoryWithPermissions } from '../interfaces';

import type { PremiumForumPermissionsClient } from './interfaces';

export class ForumPermissionsHttpClient extends AbstractPermissionsApiClient implements PremiumForumPermissionsClient {
  private get prefix() {
    return `${this.baseUrl}/api/forum`;
  }

  // eslint-disable-next-line no-useless-constructor
  constructor(params: PermissionsApiClientConstructor) {
    super(params);
  }

  getPermissionedCategories(userAndCategories: CategoriesToFilter): Promise<PostCategoryWithPermissions[]> {
    return fetch(`${this.prefix}/filter-categories`, {
      method: 'POST',
      body: JSON.stringify(userAndCategories),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  computePostPermissions(request: PermissionCompute): Promise<PostPermissionFlags> {
    return fetch(`${this.prefix}/compute-post-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  computePostCategoryPermissions(request: PermissionCompute): Promise<PostCategoryPermissionFlags> {
    return fetch(`${this.prefix}/compute-post-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  assignDefaultPostCategoryPermissions(postCategory: Resource): Promise<void> {
    console.log('Logging CLIENT', this.prefix);
    return fetch(`${this.prefix}/assign-default-post-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(postCategory),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  upsertPostCategoryPermission(request: PostCategoryPermissionAssignment): Promise<AssignedPostCategoryPermission> {
    return fetch(`${this.prefix}/upsert-post-category-permission`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  deletePostCategoryPermission(request: PermissionToDelete): Promise<void> {
    return fetch(`${this.prefix}/delete-post-category-permission`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }

  mutatePostCategorySearch(request: PostSearchToMutate): Promise<MutatedPostSearch> {
    return fetch(`${this.prefix}/mutate-post-category-search`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: {
        Authorization: `Bearer ${this.authKey}`
      }
    });
  }
}
