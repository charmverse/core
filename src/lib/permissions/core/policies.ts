import { DataNotFoundError } from '../../errors';
import { objectUtils } from '../../utilities';
import { hasAccessToSpace } from '../hasAccessToSpace';

import type { PermissionCompute, UserPermissionFlags } from './interfaces';

/**
 * In these types, we use the following naming convention:
 * R - resource type such as a Post
 * F - permission flags type
 */
type ResourceWithSpaceId = { spaceId: string };

type PermissionComputeFn<F> = (request: PermissionCompute) => Promise<F>;

export type PermissionFilteringPolicyFnInput<R, F> = {
  flags: F;
  resource: R;
  userId?: string;
  // eslint-disable-next-line @typescript-eslint/ban-types
} & (R extends ResourceWithSpaceId ? { isAdmin?: boolean } : {});

export type PermissionFilteringPolicyFn<R, F> = (input: PermissionFilteringPolicyFnInput<R, F>) => F | Promise<F>;

/**
 * @policies - permission filtering policy functions - each should be a pure function that returns a fresh set of flags rather than mutating the original flags
 */
type PolicyBuilderInput<R, F> = {
  resolver: (input: { resourceId: string }) => Promise<R | null>;
  computeFn: (input: PermissionCompute) => Promise<F>;
  policies: PermissionFilteringPolicyFn<R, F>[];
};

/**
 * This allows us to build a compute function that will apply permission filtering policies to the result, and keep the inner computation clean of nested if / else patterns
 * @type R - If the resource contains a spaceId, we can auto resolve admin status. In this case, your Permission Filtering Policies can make use of isAdmin
 */
export function buildComputePermissionsWithPermissionFilteringPolicies<R, F extends UserPermissionFlags<any>>({
  computeFn,
  resolver,
  policies
}: PolicyBuilderInput<R, F>): PermissionComputeFn<F> {
  return async (request: PermissionCompute): Promise<F> => {
    const flags = await computeFn(request);
    const resource = await resolver({ resourceId: request.resourceId });
    if (!resource) {
      throw new DataNotFoundError(`Could not find resource with ID ${request.resourceId}`);
    }

    // After each policy run, we assign the new set of flag to this variable. Flags should never become true after being false as the compute function assigns the max permissions available
    let applicableFlags = flags;

    // If the resource has a spaceId, we can auto resolve admin status
    let isAdminStatus: boolean | undefined;

    if ((resource as any as ResourceWithSpaceId).spaceId) {
      isAdminStatus = (
        await hasAccessToSpace({
          spaceId: (resource as any as ResourceWithSpaceId).spaceId,
          userId: request.userId
        })
      ).isAdmin;
    }

    for (const policy of policies) {
      let hasTrueFlag = false;

      const newFlags = await policy({
        flags: applicableFlags,
        resource,
        userId: request.userId,
        isAdmin: isAdminStatus
      } as any as PermissionFilteringPolicyFnInput<R & ResourceWithSpaceId, F>);
      // Check the policy did not add any new flags as true
      // eslint-disable-next-line no-loop-func
      objectUtils.typedKeys(newFlags).forEach((key) => {
        const flagValue = newFlags[key];

        // Adding true and not true just in case a policy returns a nullish value instead of false
        if (flagValue === true && applicableFlags[key] !== true) {
          // Prevent any policy from adding new flags
          newFlags[key] = false as any;
        }

        if (newFlags[key] === true) {
          hasTrueFlag = true;
        }
      });

      applicableFlags = newFlags;

      // Perform an early return if a policy results in fully empty permissions
      if (!hasTrueFlag) {
        return applicableFlags;
      }
    }

    return applicableFlags;
  };
}
