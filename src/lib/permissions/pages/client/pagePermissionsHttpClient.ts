import { DELETE, GET, POST } from '../../../http';
import type { PageMeta, PageMetaWithPermissions, PagesRequest } from '../../../pages/interfaces';
import { AbstractPermissionsApiClient } from '../../clients/abstractApiClient.class';
import type { PermissionCompute, PermissionResource, Resource } from '../../core/interfaces';
import type {
  AssignablePagePermissionGroups,
  AssignedPagePermission,
  PageEventTriggeringPermissions,
  PagePermissionAssignment,
  PagePermissionFlags
} from '../interfaces';

import type { PremiumPagePermissionsClient } from './interfaces';

export class PagePermissionsHttpClient extends AbstractPermissionsApiClient implements PremiumPagePermissionsClient {
  private get prefix() {
    return `${this.baseUrl}/api/pages`;
  }

  computePagePermissions(request: PermissionCompute): Promise<PagePermissionFlags> {
    return GET(`${this.prefix}/compute-page-permissions`, request);
  }

  getAccessiblePages(request: PagesRequest): Promise<PageMeta[]> {
    return GET(`${this.prefix}/list`, request);
  }

  upsertPagePermission(
    request: PagePermissionAssignment<AssignablePagePermissionGroups>
  ): Promise<AssignedPagePermission> {
    return POST(`${this.prefix}/upsert-page-permission`, request, { headers: this.jsonHeaders });
  }

  deletePagePermission(request: PermissionResource): Promise<void> {
    return DELETE(`${this.prefix}/delete-page-permission`, request, { headers: this.jsonHeaders });
  }

  listPagePermissions(request: Resource): Promise<AssignedPagePermission<AssignablePagePermissionGroups>[]> {
    return GET(`${this.prefix}/page-permissions-list`, request);
  }

  setupPagePermissionsAfterEvent(request: PageEventTriggeringPermissions): Promise<PageMetaWithPermissions> {
    return POST(`${this.prefix}/setup-page-permissions-after-event`, request, { headers: this.jsonHeaders });
  }

  lockPagePermissionsToBountyCreator(request: Resource): Promise<PageMetaWithPermissions> {
    return POST(`${this.prefix}/lock-page-permissions-to-bounty-creator`, request, { headers: this.jsonHeaders });
  }

  isBountyPageEditableByApplicants(request: Resource): Promise<{ editable: boolean }> {
    return GET(`${this.prefix}/is-bounty-page-editable-by-applicants`, request);
  }
}
