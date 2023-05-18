import type { SpaceOperation } from '../../../prisma';
import type { AssignablePermissionGroups, PermissionAssignment, UserPermissionFlags } from '../interfaces';

export type SpacePermissionFlags = UserPermissionFlags<SpaceOperation>;

export type AssignableSpacePermissionGroups = Extract<AssignablePermissionGroups, 'space' | 'role'>;

export type SpacePermissionAssignment = PermissionAssignment<AssignablePermissionGroups> & {
  operations: SpaceOperation[];
};
