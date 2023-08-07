import type { Page, ProposalStatus, WorkspaceEvent } from '@prisma/client';
import { prisma } from 'prisma-client';

import type { ProposalWithUsers } from '../../proposals/interfaces';
import { generateRole } from '../members';
import type { GenerateProposalInput } from '../proposals';
import { generateProposalCategory, generateProposal } from '../proposals';
import { generateSpaceUser, generateUserAndSpace } from '../user';

describe('generateProposal', () => {
  it('should generate a proposal with specific parameters, and return the extended proposal and page data', async () => {
    const { space, user } = await generateUserAndSpace();
    const otherUser = await generateSpaceUser({
      spaceId: space.id
    });

    const role = await generateRole({
      spaceId: space.id,
      createdBy: user.id
    });

    const proposalCategory = await generateProposalCategory({
      spaceId: space.id
    });

    const proposalPageInput: Pick<GenerateProposalInput, 'deletedAt' | 'title' | 'content'> = {
      deletedAt: new Date(),
      content: { type: 'doc', content: [] },
      title: 'Proposal title for testing'
    };

    const proposalInput: GenerateProposalInput = {
      spaceId: space.id,
      userId: user.id,
      authors: [user.id, otherUser.id],
      proposalStatus: 'review',
      reviewers: [{ group: 'role', id: role.id }],
      categoryId: proposalCategory.id,
      archived: true
    };

    const generatedProposal = await generateProposal({
      ...proposalPageInput,
      ...proposalInput
    });

    expect(generatedProposal.id).toEqual(generatedProposal.page.id);

    // Evaluate return type
    expect(generatedProposal).toMatchObject<ProposalWithUsers & { page: Page }>({
      createdBy: proposalInput.userId,
      id: expect.any(String),
      reviewedAt: null,
      reviewedBy: null,
      status: proposalInput.proposalStatus as ProposalStatus,
      snapshotProposalExpiry: null,
      archived: proposalInput.archived as boolean,
      categoryId: proposalInput.categoryId as string,
      spaceId: space.id,
      category: proposalCategory,
      page: expect.any(Object),
      evaluationType: 'vote',
      authors: expect.arrayContaining([
        {
          proposalId: generatedProposal.id,
          userId: user.id
        },
        {
          proposalId: generatedProposal.id,
          userId: otherUser.id
        }
      ]),
      reviewers: [
        {
          id: expect.any(String),
          proposalId: generatedProposal.id,
          roleId: role.id,
          userId: null
        }
      ]
    });

    const proposalPageFromDb = (await prisma.page.findUnique({
      where: {
        id: generatedProposal.id
      }
    })) as Page & { proposal: ProposalWithUsers };

    expect(generatedProposal.page).toMatchObject(proposalPageFromDb);
  });

  // This is important for simulating prod behaviour so we can test things like notifications effectively
  it('should generate a workspace event for the proposal', async () => {
    const { space, user } = await generateUserAndSpace();

    const proposal = await generateProposal({
      spaceId: space.id,
      userId: user.id,
      proposalStatus: 'discussion'
    });

    const workspaceEvents = await prisma.workspaceEvent.findMany({
      where: {
        pageId: proposal.id
      }
    });

    expect(workspaceEvents).toHaveLength(1);

    const workspaceEvent = workspaceEvents[0];

    expect(workspaceEvent).toMatchObject<WorkspaceEvent>({
      id: expect.any(String),
      pageId: proposal.id,
      spaceId: space.id,
      type: 'proposal_status_change',
      actorId: user.id,
      meta: expect.any(Object),
      createdAt: expect.any(Date)
    });
  });
});
