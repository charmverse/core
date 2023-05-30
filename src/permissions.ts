// Space permission exports
export * from './lib/permissions/spaces/interfaces';
export * from './lib/permissions/spaces/availableSpacePermissions';

// Forum permission exports
export * from './lib/permissions/forums/interfaces';
export * from './lib/permissions/forums/availablePostCategoryPermissions.class';
export * from './lib/permissions/forums/availablePostPermissions.class';
export { defaultPostPolicies, postResolver } from './lib/permissions/forums/policies/index';
export * from './lib/permissions/forums/policies/interfaces';

// Proposal permission exports
export * from './lib/permissions/proposals/interfaces';
export * from './lib/permissions/proposals/availableProposalCategoryPermissions.class';
export * from './lib/permissions/proposals/availableProposalPermissions.class';
export * from './lib/permissions/proposals/isProposalAuthor';
export * from './lib/permissions/proposals/isProposalReviewer';
export * from './lib/permissions/proposals/proposalFlowFlags';
export * from './lib/permissions/proposals/mapProposalCategoryPermissionToAssignee';
export { getDefaultProposalPermissionPolicies } from './lib/permissions/proposals/policies/index';
export * from './lib/permissions/proposals/policies/interfaces';

// Page permission exports
export * from './lib/permissions/pages/interfaces';
export * from './lib/permissions/pages/availablePagePermissions.class';
export * from './lib/permissions/pages/copyPagePermissions';
export { defaultPagePolicies, pageResolver } from './lib/permissions/pages/policies/index';
export * from './lib/permissions/pages/policies/interfaces';

// Core and general permission exports
export * from './lib/permissions/core/interfaces';
export { getPermissionAssignee } from './lib/permissions/core/getPermissionAssignee';
export * from './lib/permissions/core/policies';

export { PermissionsApiClient } from './lib/permissions/permissionsApiClient.class';
