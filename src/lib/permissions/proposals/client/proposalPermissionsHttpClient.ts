import { GET } from '../../../http/index';
import type { ListProposalsRequest } from '../../../proposals/interfaces';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type { PermissionCompute, Resource } from '../../core/interfaces';
import type { ProposalPermissionFlags, ProposalReviewerPool } from '../interfaces';

import type { PremiumProposalPermissionsClient } from './interfaces';

export class ProposalPermissionsHttpClient
  extends AbstractPermissionsApiClient
  implements PremiumProposalPermissionsClient
{
  private get prefix() {
    return `${this.baseUrl}/api/proposals`;
  }

  // eslint-disable-next-line no-useless-constructor
  constructor(params: PermissionsApiClientConstructor) {
    super(params);
  }

  getProposalReviewerPool(request: Resource): Promise<ProposalReviewerPool> {
    return GET(`${this.prefix}/reviewer-pool`, request);
  }

  getAccessibleProposalIds(request: ListProposalsRequest): Promise<string[]> {
    return GET(`${this.prefix}/list-ids`, request);
  }

  computeProposalPermissions(request: PermissionCompute): Promise<ProposalPermissionFlags> {
    return GET(`${this.prefix}/compute-proposal-permissions`, request);
  }

  computeProposalEvaluationPermissions(request: PermissionCompute): Promise<ProposalPermissionFlags> {
    return GET(`${this.prefix}/compute-proposal-evaluation-permissions`, request);
  }

  computeBaseProposalPermissions(request: PermissionCompute): Promise<ProposalPermissionFlags> {
    return GET(`${this.prefix}/compute-base-proposal-permissions`, request);
  }
}
