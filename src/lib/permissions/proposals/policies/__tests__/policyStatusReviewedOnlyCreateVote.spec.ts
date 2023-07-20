import type { ProposalCategory, Space, User } from '@prisma/client';

import type { ProposalWithUsers } from '../../../../proposals/interfaces';
import { generateProposal, generateProposalCategory } from '../../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../../testing/user';
import { AvailableSpacePermissions } from '../../../spaces/availableSpacePermissions';
import { AvailableProposalPermissions } from '../../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../../interfaces';
import { policyStatusReviewedOnlyCreateVote } from '../policyStatusReviewedOnlyCreateVote';

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
    proposalStatus: 'reviewed',
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

describe('policyStatusReviewedOnlyCreateVote', () => {
  it('should perform a no-op if the status is not reviewed', async () => {
    const permissions = await policyStatusReviewedOnlyCreateVote({
      flags: fullPermissions,
      isAdmin: false,
      resource: { ...proposal, status: 'draft' },
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
  it('should allow the author to view, create_vote, delete_vote, make public, archive and unarchive', async () => {
    const permissions = await policyStatusReviewedOnlyCreateVote({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      create_vote: true,
      view: true,
      make_public: true,
      comment: false,
      delete: true,
      edit: false,
      review: false,
      vote: false,
      archive: true,
      unarchive: true
    });
  });

  it('should preserve space-wide delete and archive permissions when space wide proposal deletion is allowed', async () => {
    const permissions = await policyStatusReviewedOnlyCreateVote({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id,
      preComputedSpacePermissionFlags: new AvailableSpacePermissions().addPermissions(['deleteAnyProposal'])
        .operationFlags
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

  it('should allow the admin to view, delete, edit, create_vote, make public, archive and unarchive', async () => {
    const permissions = await policyStatusReviewedOnlyCreateVote({
      flags: fullPermissions,
      isAdmin: true,
      resource: proposal,
      userId: adminUser.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      delete: true,
      create_vote: true,
      make_public: true,
      edit: true,
      review: false,
      comment: false,
      vote: false,
      archive: true,
      unarchive: true
    });
  });

  it('should allow reviewer to view', async () => {
    const permissions = await policyStatusReviewedOnlyCreateVote({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalReviewer.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      make_public: false,
      comment: false,
      review: false,
      edit: false,
      delete: false,
      create_vote: false,
      vote: false,
      archive: false,
      unarchive: false
    });
  });

  it('should allow space members to view', async () => {
    const permissions = await policyStatusReviewedOnlyCreateVote({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      make_public: false,
      comment: false,
      edit: false,
      delete: false,
      create_vote: false,
      review: false,
      vote: false,
      archive: false,
      unarchive: false
    });
  });
});
