import type { SpaceRole } from '@prisma/client';
import { stringUtils } from 'utilities';

import { InvalidInputError } from '../../lib/errors';
import { prisma } from '../../prisma-client';

import type { PreComputedSpaceRole } from './core/interfaces';

/**
 * @param userId - The ID of the user to check. If empty, the hasAccess should always return an error
 * @disallowGuest - If true, the user must be a member or admin of the space. If false, the user can be a guest
 */
type Input = {
  userId?: string;
  spaceId: string;
} & PreComputedSpaceRole;

interface Result {
  isAdmin?: boolean;
  spaceRole: SpaceRole | null;
}

export async function hasAccessToSpace({ userId, spaceId, preComputedSpaceRole }: Input): Promise<Result> {
  if (!spaceId || !stringUtils.isUUID(spaceId)) {
    throw new InvalidInputError(`Valid space ID is required`);
  } else if (
    preComputedSpaceRole &&
    (preComputedSpaceRole.userId !== userId || preComputedSpaceRole.spaceId !== spaceId)
  ) {
    throw new InvalidInputError(`SpaceRole userId and spaceId do not match the provided userId and spaceId`);
  } else if (!userId) {
    return { spaceRole: null };
  }
  const evaluatedSpaceRole =
    preComputedSpaceRole || preComputedSpaceRole === null
      ? preComputedSpaceRole
      : await prisma.spaceRole.findFirst({
          where: {
            spaceId,
            userId
          }
        });
  if (!evaluatedSpaceRole) {
    return { spaceRole: null };
  }
  return { isAdmin: evaluatedSpaceRole.isAdmin, spaceRole: evaluatedSpaceRole };
}
