import type { PagesRequest, PageMeta } from '../../../pages/interfaces';
import type { PermissionCompute, PermissionToDelete, Resource } from '../../interfaces';
import type { PagePermissionFlags, PagePermissionAssignment, AssignedPagePermission } from '../interfaces';

export type BasePagePermissionsClient = {
  computePagePermissions: (request: PermissionCompute) => Promise<PagePermissionFlags>;
  getAccessiblePages: (request: PagesRequest) => Promise<PageMeta[]>;
};

export type PremiumPagePermissionsClient = BasePagePermissionsClient & {
  upsertPagePermission: (request: PagePermissionAssignment) => Promise<AssignedPagePermission>;
  deletePagePermission: (request: PermissionToDelete) => Promise<void>;
  listPagePermissions: (request: Resource) => Promise<AssignedPagePermission[]>;
  lockPagePermissionsToBountyCreator: (request: Resource) => Promise<void>;
};
