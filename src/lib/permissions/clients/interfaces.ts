import type { ForumPermissionsClient } from './forum/forumInterfaces';

export type PermissionsClient = {
  forum: ForumPermissionsClient;
};

export type PermissionsApiClientConstructor = {
  baseUrl: string;
  authKey: string;
};
export * from './forum/forumInterfaces';
