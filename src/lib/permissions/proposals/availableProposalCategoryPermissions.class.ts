import type { ProposalCategoryOperation } from '@prisma/client';

import { BasePermissions } from '../core/basePermissions.class';

import { proposalCategoryOperations } from './interfaces';

export class AvailableProposalCategoryPermissions extends BasePermissions<ProposalCategoryOperation> {
  constructor() {
    super({ allowedOperations: proposalCategoryOperations.slice() });
  }
}
