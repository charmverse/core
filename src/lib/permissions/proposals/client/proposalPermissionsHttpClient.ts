import fetch from '../../../../adapters/http/fetch.server';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionsApiClientConstructor } from '../../clients/interfaces';
import type { PermissionCompute, PermissionToDelete, Resource, SpaceResourcesRequest } from '../../interfaces';
import type {
  AssignableProposalCategoryPermissionGroups,
  AssignedProposalCategoryPermission,
  ProposalCategoryPermissionAssignment,
  ProposalCategoryPermissionFlags,
  ProposalCategoryWithPermissions,
  ProposalPermissionFlags
} from '../interfaces';

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

  getProposalCategories(request: SpaceResourcesRequest): Promise<ProposalCategoryWithPermissions[]> {
    return fetch(`${this.prefix}/categories?spaceId=${request.spaceId}&userId=${request.userId}`, {
      method: 'GET',
      body: JSON.stringify(request)
    });
  }

  computeProposalPermissions(request: PermissionCompute): Promise<ProposalPermissionFlags> {
    return fetch(
      `${this.prefix}/compute-proposal-permissions?resourceId=${request.resourceId}&userId=${request.userId}`,
      {
        method: 'GET'
      }
    );
  }

  computeProposalCategoryPermissions(request: PermissionCompute): Promise<ProposalCategoryPermissionFlags> {
    return fetch(
      `${this.prefix}/compute-proposal-category-permissions?resourceId=${request.resourceId}&userId=${request.userId}`,
      {
        method: 'GET'
      }
    );
  }

  getProposalCategoryPermissions(
    request: PermissionCompute
  ): Promise<AssignedProposalCategoryPermission<AssignableProposalCategoryPermissionGroups>[]> {
    return fetch(`${this.prefix}/category-permissions-list`, {
      method: 'POST',
      body: JSON.stringify(request)
    });
  }

  assignDefaultProposalCategoryPermissions(proposalCategory: Resource): Promise<void> {
    return fetch(`${this.prefix}/assign-default-proposal-category-permissions`, {
      method: 'POST',
      body: JSON.stringify(proposalCategory),
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
