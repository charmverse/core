import type { ProposalOperation } from '../../../prisma';
import { BasePermissions } from '../core/basePermissions.class';

import { proposalOperations } from './interfaces';

export class AvailableProposalPermissions extends BasePermissions<ProposalOperation> {
  constructor() {
    super({ allowedOperations: proposalOperations.slice() });
  }
}
