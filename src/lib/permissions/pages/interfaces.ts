import type { Page, PageOperations, PagePermission, PagePermissionLevel, Role, Space, SpaceRole } from '@prisma/client';

import type { AssignablePermissionGroups, TargetPermissionGroup, UserPermissionFlags } from '../interfaces';

export type PagePermissionFlags = UserPermissionFlags<PageOperations>;

export type AssignablePagePermissionGroups = Extract<AssignablePermissionGroups, 'user' | 'role' | 'space' | 'public'>;

export const pagePermissionGroups: AssignablePagePermissionGroups[] = ['role', 'space', 'user', 'public'];

export type PagePermissionAssignmentByValues<
  T extends AssignablePagePermissionGroups = AssignablePagePermissionGroups
> = {
  permissionLevel: PagePermissionLevel;
  assignee: TargetPermissionGroup<T>;
};

export type PagePermissionAssignment<T extends AssignablePagePermissionGroups = AssignablePagePermissionGroups> = {
  pageId: string;
  permission: PagePermissionAssignmentByValues<T> | string;
};

export type AssignedPagePermission<T extends AssignablePagePermissionGroups = AssignablePagePermissionGroups> =
  PagePermissionAssignmentByValues<T> & {
    id: string;
    pageId: string;
    assignee: TargetPermissionGroup<T>;
    sourcePermission?: PagePermission;
  };

export type PagePermissionUpdate = Pick<PagePermission, 'permissionLevel'> &
  Partial<Pick<PagePermission, 'permissions'>>;

export type PagePermissionWithSource = PagePermission & {
  sourcePermission: PagePermission | null;
};

export type PageWithNestedSpaceRole = Page & {
  space: {
    spaceRoles: SpaceRole[];
  };
};

export type PagePermissionWithAssignee = PagePermission &
  PagePermissionWithSource & {
    role: Role | null;
    space: Space | null;
    public: boolean | null;
  };

export type SpaceDefaultPublicPageToggle = {
  spaceId: string;
  defaultPublicPages: boolean;
};

export type BoardPagePermissionUpdated = {
  boardId: string;
  permissionId: string;
};
