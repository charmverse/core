/* eslint-disable @typescript-eslint/ban-types */
import type { SpaceRole } from 'prisma';

import { DataNotFoundError } from '../../errors';
import { objectUtils } from '../../utilities';
import { hasAccessToSpace } from '../hasAccessToSpace';
import type { SpacePermissionFlags } from '../spaces/interfaces';

import type { PermissionCompute, PermissionComputeWithCachedData, UserPermissionFlags } from './interfaces';

/**
 * In these types, we use the following naming convention:
 * R - resource type such as a Post
 * F - permission flags type
 */
type ResourceWithSpaceId = { spaceId: string };

/**
 * @type F - The flags returned by the compute method
 * @type P - Optional additional input params
 */
// eslint-disable-next-line @typescript-eslint/ban-types
export type PermissionComputeFn<F> = (request: PermissionComputeWithCachedData) => Promise<F>;

export type PermissionFilteringPolicyFnInput<R, F, C extends boolean = false> = {
  flags: F;
  resource: R;
  userId?: string;
} & (R extends ResourceWithSpaceId
  ? C extends true
    ? { isAdmin?: boolean; spacePermissionFlags?: SpacePermissionFlags }
    : {
        isAdmin?: boolean;
      }
  : // eslint-disable-next-line @typescript-eslint/ban-types
    {});

export type PermissionFilteringPolicyFn<R, F, C extends boolean = false> = (
  input: PermissionFilteringPolicyFnInput<R, F, C>
) => F | Promise<F>;

/**
 * @policies - permission filtering policy functions - each should be a pure function that returns a fresh set of flags rather than mutating the original flags
 * @type R - The shape of the resource passed to the filtering functions
 * @type F - The flags returned by the policy check
 * @type C - Whether we should compute space permissions
 */
type PolicyBuilderInput<R, F> = {
  resolver: (input: { resourceId: string }) => Promise<R | null>;
  computeFn: PermissionComputeFn<F>;
  policies: PermissionFilteringPolicyFn<R, F>[];
  computeSpacePermissions?: PermissionComputeFn<SpacePermissionFlags>;
};

/**
 * This allows us to build a compute function that will apply permission filtering policies to the result, and keep the inner computation clean of nested if / else patterns
 * @type R - If the resource contains a spaceId, we can auto resolve admin status. In this case, your Permission Filtering Policies can make use of isAdmin
 */
export function buildComputePermissionsWithPermissionFilteringPolicies<R, F extends UserPermissionFlags<any>>({
  computeFn,
  resolver,
  policies,
  computeSpacePermissions
}: PolicyBuilderInput<R, F>): PermissionComputeFn<F> {
  return async (request: PermissionCompute): Promise<F> => {
    const resource = await resolver({ resourceId: request.resourceId });
    if (!resource) {
      throw new DataNotFoundError(`Could not find resource with ID ${request.resourceId}`);
    }
    // If the resource has a spaceId, we can auto resolve admin status
    let spaceRole: SpaceRole | undefined | null;
    let spacePermissionFlags: SpacePermissionFlags | undefined;
    const spaceId = (resource as any as ResourceWithSpaceId).spaceId;

    if (spaceId) {
      spaceRole = (
        await hasAccessToSpace({
          spaceId,
          userId: request.userId
        })
      ).spaceRole;
      if (computeSpacePermissions) {
        spacePermissionFlags = await computeSpacePermissions({
          resourceId: spaceId,
          userId: request.userId
        });
      }
    }

    const flags = await computeFn({ ...request, spacePermissionFlags, spaceRole: spaceRole ?? null });
    // After each policy run, we assign the new set of flag to this variable. Flags should never become true after being false as the compute function assigns the max permissions available
    let applicableFlags = flags;

    for (const policy of policies) {
      let hasTrueFlag = false;

      const newFlags = await policy({
        flags: applicableFlags,
        resource,
        userId: request.userId,
        isAdmin: spaceRole?.isAdmin,
        spacePermissionFlags
      } as PermissionFilteringPolicyFnInput<R & ResourceWithSpaceId, F, true>);
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
