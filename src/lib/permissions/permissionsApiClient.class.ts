import type { PermissionsApiClientConstructor } from './clients/interfaces';
import { ForumPermissionsHttpClient } from './forums/client/forumPermissionsHttpClient';
import type { BaseForumPermissionsClient, PremiumForumPermissionsClient } from './forums/client/interfaces';
import type { BasePagePermissionsClient, PremiumPagePermissionsClient } from './pages/client/interfaces';
import { PagePermissionsHttpClient } from './pages/client/pagePermissionsHttpClient';
import type { BaseProposalPermissionsClient, PremiumProposalPermissionsClient } from './proposals/client/interfaces';
import { ProposalPermissionsHttpClient } from './proposals/client/proposalPermissionsHttpClient';
import type { BaseSpacePermissionsClient, PremiumSpacePermissionsClient } from './spaces/client/interfaces';
import { SpacePermissionsHttpClient } from './spaces/client/spacePermissionsHttpClient';

export type PermissionsClient = {
  forum: BaseForumPermissionsClient;
  proposals: BaseProposalPermissionsClient;
  pages: BasePagePermissionsClient;
  spaces: BaseSpacePermissionsClient;
};

export type PremiumPermissionsClient = {
  forum: PremiumForumPermissionsClient;
  proposals: PremiumProposalPermissionsClient;
  pages: PremiumPagePermissionsClient;
  spaces: PremiumSpacePermissionsClient;
};

export class PermissionsApiClient implements PremiumPermissionsClient {
  forum: PremiumForumPermissionsClient;

  proposals: PremiumProposalPermissionsClient;

  pages: PremiumPagePermissionsClient;

  spaces: PremiumSpacePermissionsClient;

  constructor(params: PermissionsApiClientConstructor) {
    this.forum = new ForumPermissionsHttpClient(params);
    this.proposals = new ProposalPermissionsHttpClient(params);
    this.pages = new PagePermissionsHttpClient(params);
    this.spaces = new SpacePermissionsHttpClient(params);
  }
}
