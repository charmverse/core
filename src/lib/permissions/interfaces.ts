export type Resource = {
  resourceId: string;
};

export type AssignablePermissionGroups = 'user' | 'role' | 'space' | 'public';

// Public is a pure true / false. We only need to know there is a public group, to know it is true
export type TargetPermissionGroup<G extends AssignablePermissionGroups = AssignablePermissionGroups> =
  G extends 'public' ? { group: 'public' } : { group: G; id: string };

export type PermissionAssignment<T extends AssignablePermissionGroups = AssignablePermissionGroups> = Resource & {
  assignee: TargetPermissionGroup<T>;
};

/**
 * P left in as sometimes we want to specify all false / all true
 */
export type UserPermissionFlags<T extends string, P extends boolean = boolean> = Record<T, P>;

/**
 * This is the data we need to compute permissions for a resource
 * It is an improvement after Permission Compute Request, since we assume that all permission compute methods should be responsible for deciding if an admin override is available for a specific operation
 */
export type PermissionCompute = {
  resourceId: string;
  userId?: string;
};

/**
 * @publicOnly If true, ensures that authenticated requests will be treated as unauthenticated requests, only returning publicly available resources
 */
export interface AvailableResourcesRequest {
  spaceId: string;
  userId?: string;
  publicOnly?: boolean;
}

export interface AbstractPermissions<O extends string> {
  get empty(): UserPermissionFlags<O, false>;
  get full(): UserPermissionFlags<O, true>;
  get operationFlags(): UserPermissionFlags<O>;

  addPermissions(operations: O[] | Partial<UserPermissionFlags<O>>): void;

  hasPermissions(operations: O[]): boolean;
}

export type PermissionToDelete = {
  permissionId: string;
};

// --- Domain specific interfaces
export * from './spaces/interfaces';
export * from './forums/interfaces';
