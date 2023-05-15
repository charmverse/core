import type { SubscriptionTier, User } from '@prisma/client';
import { prisma } from 'prisma';
import { v4 } from 'uuid';

import { sessionUserRelations } from '../../lib/session/config';
import type { LoggedInUser } from '../../lib/user/interfaces';
import { uid } from '../../lib/utilities/strings';

import { randomETHWalletAddress } from './random';

export async function generateSpaceUser({
  spaceId,
  isAdmin,
  isGuest
}: {
  spaceId: string;
  isAdmin?: boolean;
  isGuest?: boolean;
}): Promise<LoggedInUser> {
  return prisma.user.create({
    data: {
      path: uid(),
      identityType: 'Discord',
      username: 'Username',
      wallets: {
        create: {
          address: randomETHWalletAddress()
        }
      },
      spaceRoles: {
        create: {
          space: {
            connect: {
              id: spaceId
            }
          },
          isAdmin,
          isGuest: !isAdmin && isGuest
        }
      }
    },
    include: sessionUserRelations
  });
}

/**
 * By default, all spaces are created as paid spaces in the pro tier
 */
type CreateUserAndSpaceInput = {
  user?: Partial<User>;
  isAdmin?: boolean;
  isGuest?: boolean;
  onboarded?: boolean;
  spaceName?: string;
  publicBountyBoard?: boolean;
  spacePaidTier?: SubscriptionTier;
};

export async function generateUserAndSpace({
  user,
  isAdmin,
  isGuest,
  onboarded = true,
  spaceName = 'Example Space',
  publicBountyBoard,
  spacePaidTier = 'pro'
}: CreateUserAndSpaceInput = {}) {
  const userId = v4();
  const newUser = await prisma.user.create({
    data: {
      id: userId,
      identityType: 'Wallet',
      username: `Test user ${Math.random()}`,
      spaceRoles: {
        create: {
          isAdmin,
          isGuest: !isAdmin && isGuest,
          onboarded,
          space: {
            create: {
              author: {
                connect: {
                  id: userId
                }
              },
              paidTier: spacePaidTier,
              updatedBy: userId,
              name: spaceName,
              // Adding prefix avoids this being evaluated as uuid
              domain: `domain-${v4()}`,
              publicBountyBoard
            }
          }
        }
      },
      path: uid(),
      ...user
    },
    include: {
      spaceRoles: {
        include: {
          space: true
        }
      }
    }
  });

  const { spaceRoles, ...userResult } = newUser;

  return {
    user: userResult,
    space: spaceRoles[0].space
  };
}
