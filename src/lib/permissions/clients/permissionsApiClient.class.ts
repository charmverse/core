import { ForumPermissionsHttpClient } from '../forums/client/forumPermissionsHttpClient';
import type { PremiumForumPermissionsClient } from '../forums/client/interfaces';
import type { PremiumPagePermissionsClient } from '../pages/client/interfaces';
import { PagePermissionsHttpClient } from '../pages/client/pagePermissionsHttpClient';
import type { PremiumProposalPermissionsClient } from '../proposals/client/interfaces';
import { ProposalPermissionsHttpClient } from '../proposals/client/proposalPermissionsHttpClient';

import type { PermissionsApiClientConstructor, PremiumPermissionsClient } from './interfaces';

export class PermissionsApiClient implements PremiumPermissionsClient {
  forum: PremiumForumPermissionsClient;

  proposals: PremiumProposalPermissionsClient;

  pages: PremiumPagePermissionsClient;

  constructor(params: PermissionsApiClientConstructor) {
    this.forum = new ForumPermissionsHttpClient(params);
    this.proposals = new ProposalPermissionsHttpClient(params);
    this.pages = new PagePermissionsHttpClient(params);
  }
}
