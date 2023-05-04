// import type {
//   AssignedPostCategoryPermission,
//   CategoriesToFilter,
//   MutatedPostSearch,
//   PermissionCompute,
//   PermissionToDelete,
//   PostCategoryPermissionAssignment,
//   PostCategoryPermissionFlags,
//   PostCategoryWithPermissions,
//   PostPermissionFlags,
//   PostSearchToMutate,
//   Resource
// } from '../../interfaces';

export type BaseProposalPermissionsClient = {
  isProposalReviewer: () => Promise<boolean>;
};
// eslint-disable-next-line @typescript-eslint/ban-types
export type PremiumProposalPermissionsClient = BaseProposalPermissionsClient & {
  // TODO - Add premium features
};
