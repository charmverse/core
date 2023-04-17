// Forum permissions client interface and HTTP implementation
export * from '../forums/client/interfaces';
export * from '../forums/client/forumPermissionsHttpClient';

// Unique namespace for the implementing a permissions client that can interact with all domains, like prisma client
export * from './permissionsApiClient.class';
export * from './interfaces';
