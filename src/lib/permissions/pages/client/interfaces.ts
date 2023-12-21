import type { ProposalPermissionsSwitch } from 'permissions';

import type {
  PageMetaWithPermissions,
  PagesRequest,
  UpdatePagePermissionDiscoverabilityRequest
} from '../../../pages/interfaces';
import type { PermissionCompute, PermissionResource, Resource } from '../../core/interfaces';
import type {
  AssignedPagePermission,
  BulkPagePermissionCompute,
  BulkPagePermissionFlags,
  PageEventTriggeringPermissions,
  PagePermissionAssignment,
  PagePermissionFlags
} from '../interfaces';

export type PagePermissionsClient = {
  computePagePermissions: (request: PermissionCompute & ProposalPermissionsSwitch) => Promise<PagePermissionFlags>;
  bulkComputePagePermissions: (
    request: BulkPagePermissionCompute & ProposalPermissionsSwitch
  ) => Promise<BulkPagePermissionFlags>;
  upsertPagePermission: (request: PagePermissionAssignment) => Promise<AssignedPagePermission>;
  getAccessiblePageIds: (request: PagesRequest & ProposalPermissionsSwitch) => Promise<string[]>;
  deletePagePermission: (request: PermissionResource) => Promise<void>;
  listPagePermissions: (request: Resource) => Promise<AssignedPagePermission[]>;
  lockPagePermissionsToBountyCreator: (request: Resource) => Promise<PageMetaWithPermissions>;
  setupPagePermissionsAfterEvent: (request: PageEventTriggeringPermissions) => Promise<void>;
  isBountyPageEditableByApplicants: (request: Resource) => Promise<{ editable: boolean }>;
  updatePagePermissionDiscoverability: (request: UpdatePagePermissionDiscoverabilityRequest) => Promise<void>;
};
