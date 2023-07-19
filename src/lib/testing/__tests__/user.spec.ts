import type { SpaceRole } from 'prisma-client';
import { prisma } from 'prisma-client';

import { generateUserAndSpace } from '../user';

describe('generateUserAndSpace', () => {
  it('should create a pro tier space without public proposals or bounties, and a non admin user by default', async () => {
    const { space, user } = await generateUserAndSpace();

    expect(space.publicBountyBoard).toBe(false);
    expect(space.publicProposals).toBe(false);
    expect(space.paidTier).toBe('community');

    const spaceRole = (await prisma.spaceRole.findFirst({
      where: {
        spaceId: space.id,
        userId: user.id
      }
    })) as SpaceRole;

    expect(spaceRole.isAdmin).toBe(false);
  });

  it('should pass the given parameters to the space and user admin role', async () => {
    const { space, user } = await generateUserAndSpace({
      publicBountyBoard: true,
      publicProposals: true,
      spacePaidTier: 'enterprise',
      isAdmin: true
    });

    expect(space.publicBountyBoard).toBe(true);
    expect(space.publicProposals).toBe(true);
    expect(space.paidTier).toBe('enterprise');

    const spaceRole = (await prisma.spaceRole.findFirst({
      where: {
        spaceId: space.id,
        userId: user.id
      }
    })) as SpaceRole;

    expect(spaceRole.isAdmin).toBe(true);
  });
});
