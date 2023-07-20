import { DataNotFoundError, SystemError } from './errors';

export class ProposalNotFoundError extends DataNotFoundError {
  constructor(proposalid: string) {
    super(`Proposal with ID ${proposalid} not found`);
  }
}
export class ProposalCategoryNotDeleteableError extends SystemError {
  constructor() {
    super({
      message: 'This category cannot be deleted because it contains proposals',
      errorType: 'Undesirable operation',
      severity: 'warning'
    });
  }
}

export class ProposalCategoryNotFoundError extends SystemError {
  constructor(categoryId: string) {
    super({
      message: `Proposal category with ID ${categoryId} not found`,
      errorType: 'Data not found',
      severity: 'warning'
    });
  }
}
export class ProposalCategoryPermissionNotFoundError extends DataNotFoundError {
  constructor(categoryId: string) {
    super(`Proposal category with ID ${categoryId} not found`);
  }
}
