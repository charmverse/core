// Space permission exports
export * from './lib/permissions/hasAccessToSpace';
export * from './lib/permissions/spaces/availableSpacePermissions';
export * from './lib/permissions/spaces/client/interfaces';
export * from './lib/permissions/spaces/interfaces';

// Forum permission exports
export * from './lib/permissions/forums/availablePostCategoryPermissions.class';
export * from './lib/permissions/forums/availablePostPermissions.class';
export * from './lib/permissions/forums/client/interfaces';
export * from './lib/permissions/forums/interfaces';
export * from './lib/permissions/forums/policies/index';
export * from './lib/permissions/forums/policies/interfaces';

// Proposal permission exports
export * from './lib/permissions/proposals/availableProposalPermissions.class';
export * from './lib/permissions/proposals/client/interfaces';
export * from './lib/permissions/proposals/interfaces';
export * from './lib/permissions/proposals/isProposalAuthor';

// Page permission exports
export * from './lib/permissions/pages/availablePagePermissions.class';
export * from './lib/permissions/pages/client/interfaces';
export * from './lib/permissions/pages/copyPagePermissions';
export * from './lib/permissions/pages/interfaces';
export * from './lib/permissions/pages/policies/index';
export * from './lib/permissions/pages/policies/interfaces';

// Core and general permission exports
export { getPermissionAssignee } from './lib/permissions/core/getPermissionAssignee';
export * from './lib/permissions/core/interfaces';
export * from './lib/permissions/core/policies';

export * from './lib/permissions/getSpaceInfoViaResource';
export * from './lib/permissions/permissionsApiClient.class';
