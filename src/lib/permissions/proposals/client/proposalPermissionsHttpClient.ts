import type { ListProposalsRequest, ProposalWithCommentsAndUsers, ProposalWithUsers } from 'shared';

import fetch from '../../../../adapters/http/fetch.server';
import { GET } from '../../../../adapters/http/index';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type { PermissionCompute, PermissionToDelete, Resource, SpaceResourcesRequest } from '../../interfaces';
import type {
  AssignedProposalCategoryPermission,
  ProposalCategoryPermissionAssignment,
  ProposalCategoryPermissionFlags,
  ProposalCategoryWithPermissions,
  ProposalPermissionFlags
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

  getAccessibleProposalCategories(request: SpaceResourcesRequest): Promise<ProposalCategoryWithPermissions[]> {
    return GET(`${this.prefix}/categories`, request);
  }

  getAccessibleProposals(request: ListProposalsRequest): Promise<(ProposalWithUsers | ProposalWithCommentsAndUsers)[]> {
    return GET(`${this.prefix}/list`, request);
  }

  computeProposalPermissions(request: PermissionCompute): Promise<ProposalPermissionFlags> {
    return GET(`${this.prefix}/compute-proposal-permissions`, request);
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
    return fetch(`${this.prefix}/assign-default-proposal-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: this.jsonHeaders
    });
  }

  upsertProposalCategoryPermission(
    request: ProposalCategoryPermissionAssignment
  ): Promise<AssignedProposalCategoryPermission> {
    return fetch(`${this.prefix}/upsert-proposal-category-permission`, {
      method: 'POST',
      body: JSON.stringify(request),
      headers: this.jsonHeaders
    });
  }

  deleteProposalCategoryPermission(request: PermissionToDelete): Promise<void> {
    return fetch(`${this.prefix}/delete-proposal-category-permission`, {
      method: 'DELETE',
      body: JSON.stringify(request),
      headers: this.jsonHeaders
    });
  }
}
