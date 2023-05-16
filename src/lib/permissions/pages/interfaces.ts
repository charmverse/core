import type { Page, PageOperations, PagePermission, PagePermissionLevel, Role, Space, SpaceRole } from '@prisma/client';

import type { AssignablePermissionGroups, TargetPermissionGroup, UserPermissionFlags } from '../interfaces';

export type PagePermissionFlags = UserPermissionFlags<PageOperations>;

export type AssignablePagePermissionGroups = Extract<AssignablePermissionGroups, 'user' | 'role' | 'space' | 'public'>;

export const pagePermissionGroups: AssignablePagePermissionGroups[] = ['role', 'space', 'user', 'public'];

export type PagePermissionAssignment<T extends AssignablePagePermissionGroups = AssignablePagePermissionGroups> = {
  inheritedFromPermission?: string;
  permissionLevel: PagePermissionLevel;
  assignee: TargetPermissionGroup<T>;
};

export type AssignedPagePermission<T extends AssignablePagePermissionGroups = AssignablePagePermissionGroups> =
  PagePermissionAssignment<T> & {
    id: string;
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
