import type { PageMeta, PageMetaWithPermissions, PagesRequest } from '../../../pages/interfaces';
import type { PermissionCompute, PermissionResource, Resource } from '../../core/interfaces';
import type {
  AssignedPagePermission,
  PageEventTriggeringPermissions,
  PagePermissionAssignment,
  PagePermissionFlags
} from '../interfaces';

export type BasePagePermissionsClient = {
  computePagePermissions: (request: PermissionCompute) => Promise<PagePermissionFlags>;
  getAccessiblePages: (request: PagesRequest) => Promise<PageMeta[]>;
};

export type PremiumPagePermissionsClient = BasePagePermissionsClient & {
  upsertPagePermission: (request: PagePermissionAssignment) => Promise<AssignedPagePermission>;
  deletePagePermission: (request: PermissionResource) => Promise<void>;
  listPagePermissions: (request: Resource) => Promise<AssignedPagePermission[]>;
  lockPagePermissionsToBountyCreator: (request: Resource) => Promise<PageMetaWithPermissions>;
  setupPagePermissionsAfterEvent: (request: PageEventTriggeringPermissions) => Promise<PageMetaWithPermissions>;
  isBountyPageEditableByApplicants: (request: Resource) => Promise<{ editable: boolean }>;
};
