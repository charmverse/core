import type { ProposalCategory, Space, User } from '@prisma/client';

import type { ProposalWithUsers } from '../../../../proposals/interfaces';
import { generateProposal, generateProposalCategory } from '../../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../../testing/user';
import { AvailableSpacePermissions } from '../../../spaces/availableSpacePermissions';
import { AvailableProposalPermissions } from '../../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../../interfaces';
import { policyStatusVoteClosedViewOnly } from '../policyStatusVoteClosedViewOnly';

let proposal: ProposalWithUsers;
let proposalCategory: ProposalCategory;
let space: Space;
let adminUser: User;
let proposalAuthor: User;
let proposalReviewer: User;
let spaceMember: User;

beforeAll(async () => {
  const generated = await generateUserAndSpace({
    isAdmin: true
  });

  adminUser = generated.user;
  space = generated.space;
  proposalAuthor = await generateSpaceUser({ isAdmin: false, spaceId: space.id });
  spaceMember = await generateSpaceUser({ isAdmin: false, spaceId: space.id });
  proposalReviewer = await generateSpaceUser({ isAdmin: false, spaceId: space.id });

  proposalCategory = await generateProposalCategory({
    spaceId: space.id
  });

  proposal = await generateProposal({
    categoryId: proposalCategory.id,
    authors: [proposalAuthor.id],
    proposalStatus: 'vote_closed',
    spaceId: space.id,
    userId: proposalAuthor.id,
    reviewers: [
      {
        group: 'user',
        id: proposalReviewer.id
      }
    ]
  });
});

const fullPermissions = new AvailableProposalPermissions().full;

describe('policyStatusVoteClosedViewOnly', () => {
  it('should perform a no-op if the status is not vote_closed', async () => {
    const permissions = await policyStatusVoteClosedViewOnly({
      flags: fullPermissions,
      isAdmin: false,
      resource: { ...proposal, status: 'discussion' },
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      edit: true,
      delete: true,
      comment: true,
      create_vote: true,
      review: true,
      vote: true,
      make_public: true,
      archive: true,
      unarchive: true
    });
  });

  it('should allow authors to view, make public, archive and unarchive', async () => {
    const permissions = await policyStatusVoteClosedViewOnly({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      vote: false,
      make_public: true,
      create_vote: false,
      comment: false,
      delete: false,
      edit: false,
      review: false,
      archive: true,
      unarchive: true
    });
  });

  it('should preserve space-wide delete and archive permissions when space wide proposal deletion is allowed', async () => {
    const permissions = await policyStatusVoteClosedViewOnly({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id,
      spacePermissionFlags: new AvailableSpacePermissions().addPermissions(['deleteAnyProposal']).operationFlags
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      delete: true,
      archive: true,
      unarchive: true,
      edit: false,
      comment: false,
      create_vote: false,
      review: false,
      vote: false,
      make_public: false
    });
  });

  it('should allow admins to view, make public, delete, archive and unarchive', async () => {
    const permissions = await policyStatusVoteClosedViewOnly({
      flags: fullPermissions,
      isAdmin: true,
      resource: proposal,
      userId: adminUser.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      make_public: true,
      delete: true,
      vote: false,
      create_vote: false,
      comment: false,
      edit: false,
      review: false,
      archive: true,
      unarchive: true
    });
  });

  it('should only allow users to view', async () => {
    const users = [proposalReviewer, spaceMember];

    for (const user of users) {
      const permissions = await policyStatusVoteClosedViewOnly({
        flags: fullPermissions,
        isAdmin: false,
        resource: proposal,
        userId: user.id
      });

      expect(permissions).toMatchObject<ProposalPermissionFlags>({
        view: true,
        vote: false,
        make_public: false,
        create_vote: false,
        comment: false,
        delete: false,
        edit: false,
        review: false,
        archive: false,
        unarchive: false
      });
    }
  });
});
