import type { Application, Bounty, BountyPermissionLevel, Page, Prisma } from '@prisma/client';
import { v4 } from 'uuid';

import { prisma } from '../../prisma-client';
import type { PageMetaWithPermissions } from '../pages/interfaces';
import type { TargetPermissionGroup } from '../permissions/core/interfaces';
import { typedKeys } from '../utilities/objects';

type BountyPermissions = { [key in BountyPermissionLevel]: TargetPermissionGroup[] };
type BountyWithDetails = Bounty & { applications: Application[]; page: PageMetaWithPermissions };

export async function generateBounty({
  content = undefined,
  contentText = '',
  spaceId,
  createdBy,
  status,
  maxSubmissions,
  approveSubmitters,
  title = 'Example',
  rewardToken = 'ETH',
  rewardAmount = 1,
  chainId = 1,
  bountyPermissions = {},
  pagePermissions = [],
  page = {},
  type = 'bounty',
  id
}: Pick<Bounty, 'createdBy' | 'spaceId' | 'status' | 'approveSubmitters'> &
  Partial<Pick<Bounty, 'id' | 'maxSubmissions' | 'chainId' | 'rewardAmount' | 'rewardToken'>> &
  Partial<Pick<Page, 'title' | 'content' | 'contentText' | 'type'>> & {
    bountyPermissions?: Partial<BountyPermissions>;
    pagePermissions?: Omit<Prisma.PagePermissionCreateManyInput, 'pageId'>[];
    page?: Partial<Pick<Page, 'deletedAt'>>;
  }): Promise<BountyWithDetails> {
  const pageId = id ?? v4();

  const bountyPermissionsToAssign: Omit<Prisma.BountyPermissionCreateManyInput, 'bountyId'>[] = typedKeys(
    bountyPermissions
  ).reduce((createManyInputs, permissionLevel) => {
    const permissions = bountyPermissions[permissionLevel] as TargetPermissionGroup[];

    permissions.forEach((p) => {
      createManyInputs.push({
        permissionLevel,
        userId: p.group === 'user' ? p.id : undefined,
        roleId: p.group === 'role' ? p.id : undefined,
        spaceId: p.group === 'space' ? p.id : undefined,
        public: p.group === 'public' ? true : undefined
      });
    });

    createManyInputs.push({
      permissionLevel
    });

    return createManyInputs;
  }, [] as Omit<Prisma.BountyPermissionCreateManyInput, 'bountyId'>[]);

  await prisma.$transaction([
    // Step 1 - Initialise bounty with page and bounty permissions
    prisma.bounty.create({
      data: {
        id: pageId,
        createdBy,
        chainId,
        rewardAmount,
        rewardToken,
        status,
        spaceId,
        approveSubmitters,
        maxSubmissions,
        page: {
          create: {
            id: pageId,
            createdBy,
            contentText,
            content: content ?? undefined,
            path: `page-bounty-${Math.random().toString().replace('.', '')}`,
            title: title || 'Root',
            type,
            updatedBy: createdBy,
            spaceId,
            deletedAt: page?.deletedAt ?? undefined
          }
        },
        permissions: {
          createMany: {
            data: bountyPermissionsToAssign
          }
        }
      }
    }),
    // Step 2 populate the page permissions
    prisma.pagePermission.createMany({
      data: pagePermissions.map((p) => {
        return {
          ...p,
          pageId
        };
      })
    })
  ]);

  return prisma.bounty.findUnique({
    where: {
      id: pageId
    },
    include: {
      applications: true,
      page: {
        include: {
          permissions: {
            include: {
              sourcePermission: true
            }
          }
        }
      }
    }
  }) as Promise<BountyWithDetails>;
}
