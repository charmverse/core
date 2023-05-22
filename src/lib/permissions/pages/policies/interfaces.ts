import type { Bounty, Page } from '@prisma/client';

import type { PermissionFilteringPolicyFnInput } from '../../core/policies';
import type { PagePermissionFlags } from '../interfaces';

export type PageResource = Pick<Page, 'id' | 'proposalId' | 'convertedProposalId' | 'type' | 'createdBy'> & {
  bounty: Pick<Bounty, 'createdBy' | 'spaceId' | 'status'> | null;
};
export type PagePolicyInput = PermissionFilteringPolicyFnInput<PageResource, PagePermissionFlags>;
