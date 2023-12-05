import type { ProposalCategory, Space, User } from '@prisma/client';

import type { ProposalWithUsers } from '../../../../proposals/interfaces';
import { generateProposal, generateProposalCategory } from '../../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../../testing/user';
import { AvailableSpacePermissions } from '../../../spaces/availableSpacePermissions';
import { AvailableProposalPermissions } from '../../availableProposalPermissions.class';
import type { ProposalPermissionFlags } from '../../interfaces';
import { isProposalReviewer } from '../../isProposalReviewer';
import { injectPolicyStatusEvaluationActiveCommentable } from '../policyStatusEvaluationActiveCommentable';

let proposal: ProposalWithUsers;
let proposalCategory: ProposalCategory;
let space: Space;
let adminUser: User;
let proposalAuthor: User;
let proposalReviewer: User;
let spaceMember: User;

const policyStatusEvaluationActiveCommentable = injectPolicyStatusEvaluationActiveCommentable({
  isProposalReviewer
});

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
    proposalStatus: 'evaluation_active',
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

describe('policyStatusEvaluationActiveCommentable', () => {
  it('should perform a no-op if the status is not evaluation_active', async () => {
    const permissions = await policyStatusEvaluationActiveCommentable({
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
      unarchive: true,
      evaluate: true,
      move: false
    });
  });
  it('should allow the author to view, comment, delete, make public, archive and unarchive', async () => {
    const permissions = await policyStatusEvaluationActiveCommentable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      comment: true,
      delete: true,
      make_public: true,
      edit: false,
      create_vote: false,
      review: false,
      vote: false,
      archive: true,
      unarchive: true,
      evaluate: false,
      move: false
    });
  });

  it('should allow a user who is author and reviewer to view, comment, delete, evaluate, make public, archive and unarchive', async () => {
    const proposalWithSameAuthorReviewer = await generateProposal({
      categoryId: proposalCategory.id,
      authors: [proposalAuthor.id],
      proposalStatus: 'evaluation_active',
      spaceId: space.id,
      userId: proposalAuthor.id,
      reviewers: [
        {
          group: 'user',
          id: proposalAuthor.id
        }
      ]
    });

    const permissions = await policyStatusEvaluationActiveCommentable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposalWithSameAuthorReviewer,
      userId: proposalAuthor.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      delete: true,
      review: false,
      comment: true,
      make_public: true,
      edit: false,
      create_vote: false,
      vote: false,
      archive: true,
      unarchive: true,
      evaluate: true,
      move: false
    });
  });

  it('should preserve space-wide delete and archive permissions when space wide proposal deletion is allowed', async () => {
    const permissions = await policyStatusEvaluationActiveCommentable({
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
      comment: true,
      edit: false,
      create_vote: false,
      review: false,
      vote: false,
      make_public: false,
      evaluate: false,
      move: false
    });
  });

  it('should allow the admin to view, comment, edit, delete, evaluate, make public, archive and unarchive', async () => {
    const permissions = await policyStatusEvaluationActiveCommentable({
      flags: fullPermissions,
      isAdmin: true,
      resource: proposal,
      userId: adminUser.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      edit: true,
      delete: true,
      review: false,
      comment: true,
      make_public: true,
      create_vote: false,
      vote: false,
      archive: true,
      unarchive: true,
      evaluate: true,
      move: false
    });
  });

  it('should allow reviewer to view, comment and evaluate', async () => {
    const permissions = await policyStatusEvaluationActiveCommentable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: proposalReviewer.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      comment: true,
      evaluate: true,
      review: false,
      make_public: false,
      edit: false,
      delete: false,
      create_vote: false,
      vote: false,
      archive: false,
      unarchive: false,
      move: false
    });
  });

  it('should allow space members to view and comment', async () => {
    const permissions = await policyStatusEvaluationActiveCommentable({
      flags: fullPermissions,
      isAdmin: false,
      resource: proposal,
      userId: spaceMember.id
    });

    expect(permissions).toMatchObject<ProposalPermissionFlags>({
      view: true,
      comment: true,
      make_public: false,
      edit: false,
      delete: false,
      create_vote: false,
      review: false,
      vote: false,
      archive: false,
      unarchive: false,
      evaluate: false,
      move: false
    });
  });
});
