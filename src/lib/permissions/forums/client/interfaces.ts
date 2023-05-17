import type {
  AssignedPostCategoryPermission,
  CategoriesToFilter,
  MutatedPostSearch,
  PermissionCompute,
  PermissionResource,
  PostCategoryPermissionAssignment,
  PostCategoryPermissionFlags,
  PostCategoryWithPermissions,
  PostPermissionFlags,
  PostSearchToMutate,
  Resource
} from '../../interfaces';

export type BaseForumPermissionsClient = {
  computePostPermissions: (request: PermissionCompute) => Promise<PostPermissionFlags>;
  computePostCategoryPermissions: (request: PermissionCompute) => Promise<PostCategoryPermissionFlags>;
  getPermissionedCategories: (userAndCategories: CategoriesToFilter) => Promise<PostCategoryWithPermissions[]>;
};
export type PremiumForumPermissionsClient = BaseForumPermissionsClient & {
  assignDefaultPostCategoryPermissions: (postCategory: Resource) => Promise<void>;
  upsertPostCategoryPermission: (
    assignment: PostCategoryPermissionAssignment
  ) => Promise<AssignedPostCategoryPermission>;
  deletePostCategoryPermission: (permission: PermissionResource) => Promise<void>;
  mutatePostCategorySearch: (search: PostSearchToMutate) => Promise<MutatedPostSearch>;
};
