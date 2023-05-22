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

// Pages clients
export * from '../pages/client/interfaces';
export * from '../pages/availablePagePermissions.class';
// TODO - Add this when we implement HTTP Client
// export {} from '../pages/client/proposalPermissionsHttpClient'

// Spaces clients
export * from '../spaces/client/interfaces';
export * from '../spaces/client/spacePermissionsHttpClient';

// Unique namespace for the implementing a permissions client that can interact with all domains, like prisma client
export * from './permissionsApiClient.class';
export * from './interfaces';
