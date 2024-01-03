// File: __tests__/getProposalFlagFilters.test.ts

import type { ProposalCategory, ProposalStatus, Space, User } from '@prisma/client';

import { prisma } from '../../../../prisma-client';
import { generateProposal, generateProposalCategory } from '../../../testing/proposals';
import { generateSpaceUser, generateUserAndSpace } from '../../../testing/user';
import { hasAccessToSpace } from '../../hasAccessToSpace';
import { AvailableProposalPermissions } from '../availableProposalPermissions.class';
import { isProposalAuthor } from '../isProposalAuthor';
import { isProposalReviewer } from '../isProposalReviewer';
import type { GetFlagsInput, ProposalFlowPermissionFlags } from '../proposalFlowFlags';
import { getProposalFlagFilters, TransitionFlags } from '../proposalFlowFlags';

let proposalAuthor: User;
let admin: User;
let reviewerUser: User;
let authorAndReviewerUser: User;
let spaceMember: User;
let space: Space;
let proposalCategory: ProposalCategory;
let proposalFlowFlagFilters: Record<ProposalStatus, (args: GetFlagsInput) => Promise<ProposalFlowPermissionFlags>>;

beforeAll(async () => {
  // Generate a user, admin, and space for use in tests
  ({ user: proposalAuthor, space } = await generateUserAndSpace({ isAdmin: false }));
  admin = await generateSpaceUser({ isAdmin: true, spaceId: space.id });
  reviewerUser = await generateSpaceUser({ isAdmin: false, spaceId: space.id });
  spaceMember = await generateSpaceUser({ isAdmin: false, spaceId: space.id });
  authorAndReviewerUser = await generateSpaceUser({ isAdmin: false, spaceId: space.id });

  // Generate a mock proposal linked to the space
  proposalCategory = await generateProposalCategory({
    spaceId: space.id,
    proposalCategoryPermissions: [{ assignee: { group: 'space', id: space.id }, permissionLevel: 'full_access' }]
  });

  proposalFlowFlagFilters = await getProposalFlagFilters({
    isProposalReviewer,
    countReviewers: ({ proposal }) => proposal.reviewers.length,
    // Simplified version of computeProposalPermissions from the free tier
    computeProposalPermissions: async ({ resourceId, userId }) => {
      const proposal = await prisma.proposal.findUniqueOrThrow({
        where: { id: resourceId },
        select: {
          id: true,
          status: true,
          categoryId: true,
          spaceId: true,
          createdBy: true,
          authors: true,
          reviewers: true
        }
      });
      const { spaceRole, isAdmin } = await hasAccessToSpace({
        spaceId: proposal.spaceId,
        userId
      });

      const permissions = new AvailableProposalPermissions();

      if (isAdmin) {
        return { ...permissions.full, make_public: false };
      }

      if (spaceRole) {
        if (isProposalAuthor({ proposal, userId })) {
          permissions.addPermissions([
            'edit',
            'view',
            'create_vote',
            'delete',
            'vote',
            'comment',
            'archive',
            'unarchive'
          ]);
        }

        const isReviewer = isProposalReviewer({
          proposal,
          userId
        });

        if (isReviewer) {
          permissions.addPermissions(['view', 'comment', 'review', 'evaluate', 'create_vote']);
        }

        // Add default space member permissions
        permissions.addPermissions(['view', 'comment', 'vote']);
      }

      permissions.addPermissions(['view']);

      return permissions.operationFlags;
    }
  });
});
describe('getProposalFlagFilters', () => {
  it('should allow going forward to discussion for draft proposals if user is author or admin', async () => {
    const proposalStatus: ProposalStatus = 'draft';

    const getFlags = proposalFlowFlagFilters[proposalStatus];

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: proposalAuthor.id,
      categoryId: proposalCategory.id,
      proposalStatus,
      authors: [authorAndReviewerUser.id],
      reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
    });

    // Check for author permissions
    const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
    expect(authorFlags).toMatchObject(new TransitionFlags().addPermissions(['discussion']).operationFlags);

    // Check for admin permissions
    const adminFlags = await getFlags({ userId: admin.id, proposal });
    expect(adminFlags).toMatchObject(new TransitionFlags().addPermissions(['discussion']).operationFlags);

    const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
    expect(reviewerFlags).toMatchObject(new TransitionFlags().empty);

    // Check to make sure user who is author and reviewer inherits both permission sets
    const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
    expect(authorAndReviewerFlags).toMatchObject(new TransitionFlags().addPermissions(['discussion']).operationFlags);

    const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
    expect(memberFlags).toMatchObject(new TransitionFlags().empty);
  });

  it('should allow going forward to review if user is author, admin or reviewer for discussion proposals, and going back to draft if user is author or admin', async () => {
    const proposalStatus: ProposalStatus = 'discussion';

    const getFlags = proposalFlowFlagFilters[proposalStatus];

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: proposalAuthor.id,
      categoryId: proposalCategory.id,
      proposalStatus,
      authors: [authorAndReviewerUser.id],
      reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
    });

    // Check for author permissions
    const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
    expect(authorFlags).toMatchObject(new TransitionFlags().addPermissions(['draft', 'review']).operationFlags);

    // Check for admin permissions
    const adminFlags = await getFlags({ userId: admin.id, proposal });
    expect(adminFlags).toMatchObject(new TransitionFlags().addPermissions(['draft', 'review']).operationFlags);

    const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
    expect(reviewerFlags).toMatchObject(new TransitionFlags().addPermissions(['review']).operationFlags);

    // Check to make sure user who is author and reviewer inherits both permission sets
    const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
    expect(authorAndReviewerFlags).toMatchObject(
      new TransitionFlags().addPermissions(['draft', 'review']).operationFlags
    );

    const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
    expect(memberFlags).toMatchObject(new TransitionFlags().empty);
  });

  it('should allow going forward to reviewed if user is reviewer or admin for review proposals and going back to discussion if user is author, admin or reviewer', async () => {
    const proposalStatus: ProposalStatus = 'review';

    const getFlags = proposalFlowFlagFilters[proposalStatus];

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: proposalAuthor.id,
      categoryId: proposalCategory.id,
      proposalStatus,
      authors: [authorAndReviewerUser.id],
      reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
    });

    // Check for author permissions
    const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
    expect(authorFlags).toMatchObject(new TransitionFlags().addPermissions(['discussion']).operationFlags);

    // Check for admin permissions
    const adminFlags = await getFlags({ userId: admin.id, proposal });
    expect(adminFlags).toMatchObject(new TransitionFlags().addPermissions(['discussion', 'reviewed']).operationFlags);

    const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
    expect(reviewerFlags).toMatchObject(
      new TransitionFlags().addPermissions(['discussion', 'reviewed']).operationFlags
    );

    // Check to make sure user who is author and reviewer inherits both permission sets
    const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
    expect(authorAndReviewerFlags).toMatchObject(
      new TransitionFlags().addPermissions(['discussion', 'reviewed']).operationFlags
    );

    const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
    expect(memberFlags).toMatchObject(new TransitionFlags().empty);
  });

  it('should allow going forward to vote_active for reviewed proposals if user is author, admin or reviewer, and back to review if user is admin or reviewer', async () => {
    const proposalStatus: ProposalStatus = 'reviewed';

    const getFlags = proposalFlowFlagFilters[proposalStatus];

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: proposalAuthor.id,
      categoryId: proposalCategory.id,
      proposalStatus,
      authors: [authorAndReviewerUser.id],
      reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
    });

    // Check for author permissions
    const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
    expect(authorFlags).toMatchObject(new TransitionFlags().addPermissions(['vote_active']).operationFlags);

    // Check for admin permissions
    const adminFlags = await getFlags({ userId: admin.id, proposal });
    expect(adminFlags).toMatchObject(new TransitionFlags().addPermissions(['vote_active', 'review']).operationFlags);

    const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
    expect(reviewerFlags).toMatchObject(new TransitionFlags().addPermissions(['vote_active', 'review']).operationFlags);

    const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
    expect(authorAndReviewerFlags).toMatchObject(
      new TransitionFlags().addPermissions(['review', 'vote_active']).operationFlags
    );

    const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
    expect(memberFlags).toMatchObject(new TransitionFlags().empty);
  });

  // This reflects current permissions - We might need to change this to allow manual vote closing
  it('should not allow any status change for vote_active proposals', async () => {
    const proposalStatus: ProposalStatus = 'vote_active';

    const getFlags = proposalFlowFlagFilters[proposalStatus];

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: proposalAuthor.id,
      categoryId: proposalCategory.id,
      proposalStatus,
      authors: [authorAndReviewerUser.id],
      reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
    });

    // Check for author permissions
    const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
    expect(authorFlags).toMatchObject(new TransitionFlags().empty);

    // Check for admin permissions
    const adminFlags = await getFlags({ userId: admin.id, proposal });
    expect(adminFlags).toMatchObject(new TransitionFlags().empty);

    const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
    expect(reviewerFlags).toMatchObject(new TransitionFlags().empty);

    const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
    expect(authorAndReviewerFlags).toMatchObject(new TransitionFlags().empty);

    const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
    expect(memberFlags).toMatchObject(new TransitionFlags().empty);
  });

  // This reflects current permissions - We might need to change this to allow manual vote reopening
  it('should not allow any status change for vote_closed proposals', async () => {
    const proposalStatus: ProposalStatus = 'vote_closed';

    const getFlags = proposalFlowFlagFilters[proposalStatus];

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: proposalAuthor.id,
      categoryId: proposalCategory.id,
      proposalStatus,
      authors: [authorAndReviewerUser.id],
      reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
    });

    // Check for author permissions
    const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
    expect(authorFlags).toMatchObject(new TransitionFlags().empty);

    // Check for admin permissions
    const adminFlags = await getFlags({ userId: admin.id, proposal });
    expect(adminFlags).toMatchObject(new TransitionFlags().empty);

    const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
    expect(reviewerFlags).toMatchObject(new TransitionFlags().empty);

    const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
    expect(authorAndReviewerFlags).toMatchObject(new TransitionFlags().empty);

    const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
    expect(memberFlags).toMatchObject(new TransitionFlags().empty);
  });

  describe('getProposalFlagFilters - rubric evaluations', () => {
    it('should allow going forward to evaluation_active if user is author, admin or reviewer for discussion proposals, and going back to draft if user is author or admin ', async () => {
      const proposalStatus: ProposalStatus = 'discussion';

      const getFlags = proposalFlowFlagFilters[proposalStatus];

      const proposal = await generateProposal({
        spaceId: space.id,
        userId: proposalAuthor.id,
        categoryId: proposalCategory.id,
        proposalStatus,
        evaluationType: 'rubric',
        authors: [authorAndReviewerUser.id],
        reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
      });

      // Check for author permissions
      const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
      expect(authorFlags).toMatchObject(
        new TransitionFlags().addPermissions(['draft', 'evaluation_active']).operationFlags
      );

      // Check for admin permissions
      const adminFlags = await getFlags({ userId: admin.id, proposal });
      expect(adminFlags).toMatchObject(
        new TransitionFlags().addPermissions(['draft', 'evaluation_active']).operationFlags
      );

      const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
      expect(reviewerFlags).toMatchObject(new TransitionFlags().addPermissions(['evaluation_active']).operationFlags);

      // Check to make sure user who is author and reviewer inherits both permission sets
      const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
      expect(authorAndReviewerFlags).toMatchObject(
        new TransitionFlags().addPermissions(['draft', 'evaluation_active']).operationFlags
      );

      const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
      expect(memberFlags).toMatchObject(new TransitionFlags().empty);
    });

    it('should allow going forward to evaluation_closed if user is admin or reviewer for evaluation_active proposals, and going back to discussion if user is author, admin or reviewer', async () => {
      const proposalStatus: ProposalStatus = 'evaluation_active';

      const getFlags = proposalFlowFlagFilters[proposalStatus];

      const proposal = await generateProposal({
        spaceId: space.id,
        userId: proposalAuthor.id,
        categoryId: proposalCategory.id,
        proposalStatus,
        authors: [authorAndReviewerUser.id],
        reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
      });

      // Check for author permissions
      const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
      expect(authorFlags).toMatchObject(new TransitionFlags().addPermissions(['discussion']).operationFlags);

      // Check for admin permissions
      const adminFlags = await getFlags({ userId: admin.id, proposal });
      expect(adminFlags).toMatchObject(
        new TransitionFlags().addPermissions(['discussion', 'evaluation_closed']).operationFlags
      );

      const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
      expect(reviewerFlags).toMatchObject(
        new TransitionFlags().addPermissions(['discussion', 'evaluation_closed']).operationFlags
      );

      // Check to make sure user who is author and reviewer inherits both permission sets
      const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
      expect(authorAndReviewerFlags).toMatchObject(
        new TransitionFlags().addPermissions(['discussion', 'evaluation_closed']).operationFlags
      );

      const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
      expect(memberFlags).toMatchObject(new TransitionFlags().empty);
    });

    it('should allow going back to evaluation_active for evaluation_closed proposals if user is admin or reviewer', async () => {
      const proposalStatus: ProposalStatus = 'evaluation_closed';

      const getFlags = proposalFlowFlagFilters[proposalStatus];

      const proposal = await generateProposal({
        spaceId: space.id,
        userId: proposalAuthor.id,
        categoryId: proposalCategory.id,
        proposalStatus,
        authors: [authorAndReviewerUser.id],
        reviewers: [{ userId: reviewerUser.id }, { userId: authorAndReviewerUser.id }]
      });

      // Check for author permissions
      const authorFlags = await getFlags({ userId: proposalAuthor.id, proposal });
      expect(authorFlags).toMatchObject(new TransitionFlags().empty);

      // Check for admin permissions
      const adminFlags = await getFlags({ userId: admin.id, proposal });
      expect(adminFlags).toMatchObject(new TransitionFlags().addPermissions(['evaluation_active']).operationFlags);

      const reviewerFlags = await getFlags({ userId: reviewerUser.id, proposal });
      expect(reviewerFlags).toMatchObject(new TransitionFlags().addPermissions(['evaluation_active']).operationFlags);

      // Check to make sure user who is author and reviewer inherits both permission sets
      const authorAndReviewerFlags = await getFlags({ userId: authorAndReviewerUser.id, proposal });
      expect(authorAndReviewerFlags).toMatchObject(
        new TransitionFlags().addPermissions(['evaluation_active']).operationFlags
      );

      const memberFlags = await getFlags({ userId: spaceMember.id, proposal });
      expect(memberFlags).toMatchObject(new TransitionFlags().empty);
    });
  });
});
