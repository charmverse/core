import type { Page, ProposalStatus } from '@prisma/client';
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

    const customProperties = {
      first: 1,
      second: 2
    };

    const proposalInput: GenerateProposalInput = {
      spaceId: space.id,
      userId: user.id,
      authors: [user.id, otherUser.id],
      proposalStatus: 'review',
      reviewers: [{ group: 'role', id: role.id }],
      categoryId: proposalCategory.id,
      archived: true,
      customProperties
    };

    const generatedProposal = await generateProposal({
      ...proposalPageInput,
      ...proposalInput
    });

    expect(generatedProposal.id).toEqual(generatedProposal.page.id);

    // Evaluate return type
    expect(generatedProposal).toMatchObject<ProposalWithUsers & { page: Page }>({
      lensPostLink: null,
      publishToLens: null,
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
      fields: {
        properties: customProperties
      },
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
      ],
      rewards: []
    });

    const proposalPageFromDb = (await prisma.page.findUnique({
      where: {
        id: generatedProposal.id
      }
    })) as Page & { proposal: ProposalWithUsers };

    expect(generatedProposal.page).toMatchObject(proposalPageFromDb);
  });
});
