import { prisma } from '../../../../prisma-client';

import type { PageResource } from './interfaces';

export function pageResolver({ resourceId }: { resourceId: string }) {
  return prisma.page.findUnique({
    where: {
      id: resourceId
    },
    select: {
      createdBy: true,
      id: true,
      proposalId: true,
      convertedProposalId: true,
      type: true,
      spaceId: true,
      bounty: {
        select: {
          createdBy: true,
          status: true,
          spaceId: true
        }
      }
    }
  }) as Promise<PageResource>;
}
