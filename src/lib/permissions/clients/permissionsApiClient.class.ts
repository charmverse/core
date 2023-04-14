import type { ForumPermissionsClient } from './forum/forumInterfaces';
import { ForumPermissionsHttpClient } from './forum/forumPermissionsHttpClient';
import type { PermissionsApiClientConstructor, PermissionsClient } from './interfaces';

export class PermissionsApiClient implements PermissionsClient {
  forum: ForumPermissionsClient;

  constructor(params: PermissionsApiClientConstructor) {
    this.forum = new ForumPermissionsHttpClient(params);
  }
}
