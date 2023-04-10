import type { PostCategoryOperation, PostOperation } from '@prisma/client';

import type { PermissionCompute, UserPermissionFlags } from '../../interfaces';

export type PostPermissionFlags = UserPermissionFlags<PostOperation>;
export type PostCategoryPermissionFlags = UserPermissionFlags<PostCategoryOperation>;

export type ForumPermissionsClient = {
  computePostPermissions: (request: PermissionCompute) => Promise<PostPermissionFlags>;
  computePostCategoryPermissions: (request: PermissionCompute) => Promise<PostCategoryPermissionFlags>;
};
