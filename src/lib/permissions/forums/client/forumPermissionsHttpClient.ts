import fetch from '../../../../adapters/http/fetch.server';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type { PermissionCompute, PermissionResource, Resource } from '../../core/interfaces';
import type {
  AssignedPostCategoryPermission,
  MutatedPostSearch,
  PostCategoryPermissionFlags,
  PostPermissionFlags,
  PostSearchToMutate,
  CategoriesToFilter,
  PostCategoryPermissionAssignment,
  PostCategoryWithPermissions
} from '../interfaces';

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
    return fetch(`${this.prefix}/get-permissioned-categories`, {
      method: 'POST',
      body: JSON.stringify(userAndCategories),
      headers: this.jsonHeaders
    });
  }

  computePostPermissions(request: PermissionCompute): Promise<PostPermissionFlags> {
    return fetch(`${this.prefix}/compute-post-permissions?resourceId=${request.resourceId}&userId=${request.userId}`, {
      method: 'GET'
    });
  }

  computePostCategoryPermissions(request: PermissionCompute): Promise<PostCategoryPermissionFlags> {
    return fetch(
      `${this.prefix}/compute-post-category-permissions?resourceId=${request.resourceId}&userId=${request.userId}`,
      {
        method: 'GET'
      }
    );
  }

  assignDefaultPostCategoryPermissions(postCategory: Resource): Promise<void> {
    return fetch(`${this.prefix}/assign-default-post-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(postCategory)
    });
  }

  upsertPostCategoryPermission(request: PostCategoryPermissionAssignment): Promise<AssignedPostCategoryPermission> {
    return fetch(`${this.prefix}/upsert-post-category-permission`, {
      method: 'POST',
      body: JSON.stringify(request)
    });
  }

  deletePostCategoryPermission(request: PermissionResource): Promise<void> {
    return fetch(`${this.prefix}/delete-post-category-permission`, {
      method: 'DELETE',
      body: JSON.stringify(request)
    });
  }

  mutatePostCategorySearch(request: PostSearchToMutate): Promise<MutatedPostSearch> {
    return fetch(`${this.prefix}/mutate-post-category-search`, {
      method: 'POST',
      body: JSON.stringify(request)
    });
  }
}
