// Space permission exports
export * from './lib/permissions/spaces/interfaces';
export * from './lib/permissions/spaces/availableSpacePermissions';
export * from './lib/permissions/hasAccessToSpace';
export * from './lib/permissions/spaces/client/interfaces';

// Forum permission exports
export * from './lib/permissions/forums/interfaces';
export * from './lib/permissions/forums/availablePostCategoryPermissions.class';
export * from './lib/permissions/forums/availablePostPermissions.class';
export * from './lib/permissions/forums/policies/index';
export * from './lib/permissions/forums/policies/interfaces';
export * from './lib/permissions/forums/client/interfaces';

// Proposal permission exports
export * from './lib/permissions/proposals/interfaces';
export * from './lib/permissions/proposals/availableProposalCategoryPermissions.class';
export * from './lib/permissions/proposals/availableProposalPermissions.class';
export * from './lib/permissions/proposals/isProposalAuthor';
export * from './lib/permissions/proposals/isProposalReviewer';
export * from './lib/permissions/proposals/proposalFlowFlags';
export * from './lib/permissions/proposals/mapProposalCategoryPermissionToAssignee';
export * from './lib/permissions/proposals/policies/index';
export * from './lib/permissions/proposals/policies/interfaces';
export * from './lib/permissions/proposals/client/interfaces';

// Page permission exports
export * from './lib/permissions/pages/interfaces';
export * from './lib/permissions/pages/availablePagePermissions.class';
export * from './lib/permissions/pages/copyPagePermissions';
export * from './lib/permissions/pages/policies/index';
export * from './lib/permissions/pages/policies/interfaces';
export * from './lib/permissions/pages/client/interfaces';

// Core and general permission exports
export * from './lib/permissions/core/interfaces';
export { getPermissionAssignee } from './lib/permissions/core/getPermissionAssignee';
export * from './lib/permissions/core/policies';

export * from './lib/permissions/permissionsApiClient.class';
