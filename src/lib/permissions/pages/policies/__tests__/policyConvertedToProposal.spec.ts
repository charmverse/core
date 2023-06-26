import type { Page, Space, User } from '@prisma/client';
import { prisma } from 'prisma-client';

import { generatePage } from '../../../../testing/pages';
import { generateProposal } from '../../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../../testing/user';
import { AvailablePagePermissions } from '../../availablePagePermissions.class';
import { policyConvertedToProposal } from '../policyConvertedToProposal';

describe('policyConvertedToProposal', () => {
  let space: Space;
  let admin: User;
  let member: User;
  let page: Page;
  let pageConvertedToProposal: Page;
  const fullPermissionFlags = new AvailablePagePermissions().full;
  const emptyPermissionFlags = new AvailablePagePermissions().empty;

  beforeAll(async () => {
    const generated = await generateUserAndSpace({
      isAdmin: true
    });
    space = generated.space;
    admin = generated.user;
    member = await generateSpaceUser({
      spaceId: space.id,
      isAdmin: false
    });
    page = await generatePage({
      createdBy: admin.id,
      spaceId: space.id
    });
    pageConvertedToProposal = await generatePage({
      createdBy: admin.id,
      spaceId: space.id
    });
    const proposal = await generateProposal({
      spaceId: space.id,
      userId: admin.id
    });
    pageConvertedToProposal = await prisma.page.update({
      where: {
        id: pageConvertedToProposal.id
      },
      data: {
        convertedProposalId: proposal.id
      }
    });
  });

  it('should not have an effect if convertedToProposalId is null', async () => {
    const updated = await policyConvertedToProposal({
      flags: { ...fullPermissionFlags },
      resource: page,
      userId: member.id
    });

    expect(updated).toEqual(fullPermissionFlags);
  });
  it('should not allow a space member to delete or edit a page converted to a proposal, but still allow them to view it', async () => {
    const updated = await policyConvertedToProposal({
      flags: fullPermissionFlags,
      resource: pageConvertedToProposal,
      userId: member.id
    });

    expect(updated).toEqual({
      ...emptyPermissionFlags,
      read: true
    });
  });

  it('should not remove any permission from a space admin', async () => {
    const updated = await policyConvertedToProposal({
      flags: { ...fullPermissionFlags },
      resource: pageConvertedToProposal,
      userId: admin.id,
      isAdmin: true
    });

    expect(updated).toEqual(fullPermissionFlags);
  });
});
