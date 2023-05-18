import type { Page } from '@prisma/client';

import type { PermissionFilteringPolicyFnInput } from '../../core/policies';
import type { PagePermissionFlags } from '../interfaces';

export type PageResource = Pick<Page, 'id' | 'proposalId' | 'convertedProposalId' | 'type' | 'createdBy'>;
export type PagePolicyInput = PermissionFilteringPolicyFnInput<PageResource, PagePermissionFlags>;
