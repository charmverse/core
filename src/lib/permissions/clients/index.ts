// Forum permissions client interface and HTTP implementation
export * from '../forums/client/interfaces';
export * from '../forums/client/forumPermissionsHttpClient';
export * from '../forums/availablePostCategoryPermissions.class';
export * from '../forums/availablePostPermissions.class';

// Proposal permissions client interface and HTTP implementation
export * from '../proposals/client/interfaces';
export * from '../proposals/client/proposalPermissionsHttpClient';
export * from '../proposals/availableProposalCategoryPermissions.class';
export * from '../proposals/availableProposalPermissions.class';

// Unique namespace for the implementing a permissions client that can interact with all domains, like prisma client
export * from './permissionsApiClient.class';
export * from './interfaces';
