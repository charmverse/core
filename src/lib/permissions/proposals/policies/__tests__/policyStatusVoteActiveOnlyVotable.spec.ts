import type { ProposalCategory, Space, User } from '@prisma/client';

import { proposalResolver } from '..';
import { generateProposal } from '../../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../../testing/user';
import { AvailableSpacePermissions } from '../../../spaces/availableSpacePermissions';
import { AvailableProposalPermissions } from '../../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../../interfaces';
import type { ProposalResource } from '../interfaces';
import { policyStatusVoteActiveOnlyVotable } from '../policyStatusVoteActiveOnlyVotable';

let proposal: ProposalResource;
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

  proposal = await generateProposal({
    authors: [proposalAuthor.id],
    proposalStatus: 'vote_active',
    spaceId: space.id,
    userId: proposalAuthor.id,
    reviewers: [
      {
        group: 'user',
        id: proposalReviewer.id
      }
    ]
  }).then((_proposal) => proposalResolver({ resourceId: _proposal.id }));
});

const fullPermissions = new AvailableProposalPermissions().full;

describe('policyStatusVoteActiveOnlyVotable', () => {
  it('should perform a no-op if the status is not vote_active', async () => {
    const permissions = await policyStatusVoteActiveOnlyVotable({
      flags: { ...fullPermissions, move: false },
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
      unarchive: true,
      evaluate: true,
      move: false
    });
  });
  it('should allow author to view, comment, update vote, vote make the proposal public', async () => {
    const permissions = await policyStatusVoteActiveOnlyVotable({
      flags: { ...fullPermissions, move: false },
      isAdmin: false,
      resource: proposal,
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      vote: true,
      make_public: true,
      create_vote: true,
      comment: true,
      delete: false,
      edit: false,
      review: false,
      archive: false,
      unarchive: false,
      evaluate: false,
      move: false
    });
  });

  it('should preserve space-wide delete permissions when space wide proposal deletion is allowed', async () => {
    const permissions = await policyStatusVoteActiveOnlyVotable({
      flags: { ...fullPermissions, move: false },
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id,
      preComputedSpacePermissionFlags: new AvailableSpacePermissions().addPermissions(['deleteAnyProposal'])
        .operationFlags
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      delete: true,
      archive: false,
      unarchive: false,
      edit: false,
      comment: false,
      create_vote: false,
      review: false,
      vote: false,
      make_public: false,
      evaluate: false,
      move: false
    });
  });

  it('should allow admin users to view, vote, update vote, make the proposal public and delete it', async () => {
    const permissions = await policyStatusVoteActiveOnlyVotable({
      flags: { ...fullPermissions, move: false },
      isAdmin: true,
      resource: proposal,
      userId: adminUser.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      vote: true,
      make_public: true,
      delete: true,
      create_vote: true,
      comment: true,
      edit: false,
      review: false,
      archive: false,
      unarchive: false,
      evaluate: false,
      move: false
    });
  });

  it('should allow users to view, comment and vote', async () => {
    const users = [proposalReviewer, spaceMember];

    for (const user of users) {
      const permissions = await policyStatusVoteActiveOnlyVotable({
        flags: { ...fullPermissions, move: false },
        isAdmin: false,
        resource: proposal,
        userId: user.id
      });

      expect(permissions).toMatchObject<ProposalPermissionFlags>({
        view: true,
        vote: true,
        make_public: false,
        create_vote: false,
        comment: true,
        delete: false,
        edit: false,
        review: false,
        archive: false,
        unarchive: false,
        evaluate: false,
        move: false
      });
    }
  });
});
