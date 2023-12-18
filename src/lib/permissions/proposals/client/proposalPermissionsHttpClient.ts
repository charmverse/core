import { DELETE, GET, POST } from '../../../http/index';
import type {
  ListProposalsRequest,
  ProposalWithCommentsAndUsers,
  ProposalWithUsers
} from '../../../proposals/interfaces';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type { PermissionCompute, PermissionResource, Resource, SpaceResourcesRequest } from '../../core/interfaces';
import type {
  AssignedProposalCategoryPermission,
  ProposalCategoryPermissionAssignment,
  ProposalCategoryPermissionFlags,
  ProposalCategoryWithPermissions,
  ProposalPermissionFlags,
  ProposalReviewerPool
} from '../interfaces';
import type { ProposalFlowPermissionFlags } from '../proposalFlowFlags';

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

  getAccessibleProposalCategories(request: SpaceResourcesRequest): Promise<ProposalCategoryWithPermissions[]> {
    return GET(`${this.prefix}/categories`, request);
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

  computeProposalFlowPermissions(request: PermissionCompute): Promise<ProposalFlowPermissionFlags> {
    return GET(`${this.prefix}/compute-proposal-flow-permissions`, request);
  }

  computeProposalCategoryPermissions(request: PermissionCompute): Promise<ProposalCategoryPermissionFlags> {
    return GET(`${this.prefix}/compute-proposal-category-permissions`, request);
  }

  getProposalCategoryPermissions(request: PermissionCompute): Promise<AssignedProposalCategoryPermission[]> {
    return GET(`${this.prefix}/category-permissions-list`, request);
  }

  assignDefaultProposalCategoryPermissions(request: Resource): Promise<void> {
    return POST(`${this.prefix}/assign-default-proposal-category-permissions`, request, {
      headers: this.jsonHeaders
    });
  }

  upsertProposalCategoryPermission(
    request: ProposalCategoryPermissionAssignment
  ): Promise<AssignedProposalCategoryPermission> {
    return POST(`${this.prefix}/upsert-proposal-category-permission`, request, {
      headers: this.jsonHeaders
    });
  }

  deleteProposalCategoryPermission(request: PermissionResource): Promise<void> {
    return DELETE(`${this.prefix}/delete-proposal-category-permission`, request, {
      headers: this.jsonHeaders
    });
  }
}
