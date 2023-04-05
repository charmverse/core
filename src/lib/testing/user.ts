import { User } from "@prisma/client";
import { prisma } from "db";
import { sessionUserRelations } from "lib/session/config";
import { LoggedInUser } from "lib/user/interfaces";
import { uid,  } from "lib/utilities/strings";
import { v4 } from "uuid";
import { randomETHWalletAddress } from "./random";

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



type CreateUserAndSpaceInput = {
    user?: Partial<User>;
    isAdmin?: boolean;
    isGuest?: boolean;
    onboarded?: boolean;
    spaceName?: string;
    publicBountyBoard?: boolean;
  };

export async function generateUserAndSpace({
    user,
    isAdmin,
    isGuest,
    onboarded = true,
    spaceName = 'Example Space',
    publicBountyBoard
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