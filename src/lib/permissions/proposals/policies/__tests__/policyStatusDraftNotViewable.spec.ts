import type { ProposalCategory, Space, User } from '@prisma/client';

import type { ProposalWithUsers } from '../../../../proposals/interfaces';
import { generateProposal, generateProposalCategory } from '../../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../../testing/user';
import { AvailableSpacePermissions } from '../../../spaces/availableSpacePermissions';
import { AvailableProposalPermissions } from '../../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../../interfaces';
import { policyStatusDraftNotViewable } from '../policyStatusDraftNotViewable';

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
    proposalStatus: 'draft',
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

describe('policyStatusDraftOnlyViewable', () => {
  it('should perform a no-op if the status is not draft', async () => {
    const permissions = await policyStatusDraftNotViewable({
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
      unarchive: true,
      evaluate: true
    });
  });
  it('should allow the author to view, edit, comment, delete, make public, archive and unarchive', async () => {
    const permissions = await policyStatusDraftNotViewable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      edit: true,
      delete: true,
      comment: true,
      make_public: true,
      create_vote: false,
      review: false,
      vote: false,
      archive: true,
      unarchive: true,
      evaluate: false
    });
  });

  it('should return same level of permissions as the author for an admin', async () => {
    const permissions = await policyStatusDraftNotViewable({
      flags: fullPermissions,
      isAdmin: true,
      resource: proposal,
      userId: adminUser.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      edit: true,
      delete: true,
      comment: true,
      make_public: true,
      create_vote: false,
      review: false,
      vote: false,
      archive: true,
      unarchive: true,
      evaluate: false
    });
  });

  it('should not allow the reviewer to view the proposal', async () => {
    const permissions = await policyStatusDraftNotViewable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalReviewer.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: false,
      edit: false,
      delete: false,
      comment: false,
      make_public: false,
      create_vote: false,
      review: false,
      vote: false,
      archive: false,
      unarchive: false,
      evaluate: false
    });
  });
  it('should preserve space-wide delete and archive permissions when space wide proposal deletion is allowed', async () => {
    const permissions = await policyStatusDraftNotViewable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id,
      preComputedSpacePermissionFlags: new AvailableSpacePermissions().addPermissions(['deleteAnyProposal'])
        .operationFlags
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      edit: false,
      delete: true,
      comment: false,
      create_vote: false,
      review: false,
      vote: false,
      make_public: false,
      archive: true,
      unarchive: true,
      evaluate: false
    });
  });
  it('should not allow space members to view the proposal', async () => {
    const permissions = await policyStatusDraftNotViewable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: false,
      edit: false,
      delete: false,
      comment: false,
      create_vote: false,
      review: false,
      vote: false,
      make_public: false,
      archive: false,
      unarchive: false,
      evaluate: false
    });
  });
});
