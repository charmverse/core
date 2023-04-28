import type { PostCategory, PostCategoryOperation, PostCategoryPermissionLevel, PostOperation } from '@prisma/client';

import type { AssignablePermissionGroups, TargetPermissionGroup, UserPermissionFlags } from '../interfaces';

export type PostPermissionFlags = UserPermissionFlags<PostOperation>;
export type PostCategoryPermissionFlags = UserPermissionFlags<PostCategoryOperation>;
export type AssignablePostCategoryPermissionGroups = Extract<AssignablePermissionGroups, 'role' | 'space' | 'public'>;

export type PostCategoryPermissionAssignment<
  T extends AssignablePostCategoryPermissionGroups = AssignablePostCategoryPermissionGroups
> = {
  postCategoryId: string;
  permissionLevel: PostCategoryPermissionLevel;
  assignee: TargetPermissionGroup<T>;
};

export type AssignedPostCategoryPermission<
  T extends AssignablePostCategoryPermissionGroups = AssignablePostCategoryPermissionGroups
> = PostCategoryPermissionAssignment<T> & {
  id: string;
};

export type PostSearchToMutate = {
  categoryId?: string | string[];
  spaceId: string;
  userId?: string;
};

export type MutatedPostSearch = {
  categoryId?: string | string[];
};

/**
 * When returning post categories, also pre-compute if a user can add a post to that category
 */
export type PostCategoryWithPermissions = PostCategory & { permissions: PostCategoryPermissionFlags };

/**
 * Used for returning a subset of post categories
 */
export type CategoriesToFilter = {
  postCategories: PostCategory[];
  userId?: string;
};
