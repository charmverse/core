// Forum permissions client interface and HTTP implementation
export type { ForumPermissionsClient } from './forum/forumInterfaces';
export { ForumPermissionsHttpClient } from './forum/forumPermissionsHttpClient';

// Unique namespace for the implementing a permissions client that can interact with all domains, like prisma client
export type { PermissionsClient } from './interfaces';
