import type {
  AssignedPostCategoryPermission,
  CategoriesToFilter,
  MutatedPostSearch,
  PermissionCompute,
  PermissionToDelete,
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
};
export type PremiumForumPermissionsClient = BaseForumPermissionsClient & {
  assignDefaultPostCategoryPermissions: (postCategory: Resource) => Promise<void>;
  upsertPostCategoryPermission: (
    assignment: PostCategoryPermissionAssignment
  ) => Promise<AssignedPostCategoryPermission>;
  deletePostCategoryPermission: (permission: PermissionToDelete) => Promise<void>;
  mutatePostCategorySearch: (search: PostSearchToMutate) => Promise<MutatedPostSearch>;
  filterAccessiblePostCategories: (userAndCategories: CategoriesToFilter) => Promise<PostCategoryWithPermissions[]>;
};
