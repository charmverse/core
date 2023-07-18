import type { SpaceRole } from '@prisma/client';
import { stringUtils } from 'utilities';

import { InvalidInputError } from '../../lib/errors';
import { prisma } from '../../prisma-client';

/**
 * @param userId - The ID of the user to check. If empty, the hasAccess should always return an error
 * @disallowGuest - If true, the user must be a member or admin of the space. If false, the user can be a guest
 */
interface Input {
  userId?: string;
  spaceId: string;
  spaceRole?: SpaceRole | null;
}

interface Result {
  isAdmin?: boolean;
  spaceRole: SpaceRole | null;
}

export async function hasAccessToSpace({ userId, spaceId, spaceRole }: Input): Promise<Result> {
  if (spaceRole && (spaceRole.userId !== userId || spaceRole.spaceId !== spaceId)) {
    throw new InvalidInputError(`SpaceRole userId and spaceId do not match the provided userId and spaceId`);
  } else if (!userId) {
    return { spaceRole: null };
  } else if (!spaceId || !stringUtils.isUUID(spaceId)) {
    throw new InvalidInputError(`Valid space ID is required`);
  }

  const evaluatedSpaceRole =
    spaceRole || spaceRole === null
      ? spaceRole
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
