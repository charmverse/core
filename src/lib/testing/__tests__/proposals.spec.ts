import type {
  Page,
  ProposalCategory,
  ProposalEvaluation,
  ProposalEvaluationPermission,
  ProposalReviewer,
  ProposalRubricCriteria,
  ProposalStatus,
  Role,
  Space,
  User
} from '@prisma/client';
import { v4 as uuid } from 'uuid';

import { prisma } from '../../../prisma-client';
import { InvalidInputError } from '../../errors';
import type { ProposalWithUsers } from '../../proposals/interfaces';
import { generateRole } from '../members';
import type { GenerateProposalInput, ProposalEvaluationTestInput } from '../proposals';
import { generateProposal } from '../proposals';
import { generateSpaceUser, generateUserAndSpace } from '../user';

describe('generateProposal', () => {
  let space: Space;
  let user: User;
  let role: Role;
  let proposalCategory: ProposalCategory;

  beforeAll(async () => {
    ({ space, user } = await generateUserAndSpace());
    role = await generateRole({
      spaceId: space.id,
      createdBy: user.id
    });
  });
  it('should generate a proposal with specific parameters, and return the extended proposal and page data', async () => {
    const otherUser = await generateSpaceUser({
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
      proposalStatus: 'published',
      reviewers: [{ group: 'role', id: role.id }],
      archived: true,
      customProperties
    };

    const generatedProposal = await generateProposal({
      ...proposalPageInput,
      ...proposalInput
    });

    expect(generatedProposal.id).toEqual(generatedProposal.page.id);

    // Evaluate return type
    expect(generatedProposal).toMatchObject<ProposalWithUsers & { page: Page }>(
      expect.objectContaining({
        createdBy: proposalInput.userId,
        id: expect.any(String),
        status: proposalInput.proposalStatus as ProposalStatus,
        archived: proposalInput.archived as boolean,
        spaceId: space.id,
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
        reviewers: expect.arrayContaining([
          {
            id: expect.any(String),
            proposalId: generatedProposal.id,
            roleId: role.id,
            userId: null,
            evaluationId: null,
            systemRole: null
          }
        ])
      })
    );

    const proposalPageFromDb = (await prisma.page.findUnique({
      where: {
        id: generatedProposal.id
      }
    })) as Page & { proposal: ProposalWithUsers };

    expect(generatedProposal.page).toMatchObject(proposalPageFromDb);
  });

  it('should create the evaluation steps correctly along with attached permissions and rubric criteria', async () => {
    const proposalPageInput: Pick<GenerateProposalInput, 'deletedAt' | 'title' | 'content'> = {
      deletedAt: new Date(),
      content: { type: 'doc', content: [] },
      title: 'Proposal title for testing'
    };

    const customProperties = {
      first: 1,
      second: 2
    };

    const vote = await prisma.vote.create({
      data: {
        deadline: new Date(),
        status: 'InProgress',
        threshold: 10,
        title: 'Example',
        author: { connect: { id: user.id } },
        space: { connect: { id: space.id } }
      }
    });

    const evaluationSteps: ProposalEvaluationTestInput[] = [
      {
        completedAt: new Date(),
        evaluationType: 'rubric',
        rubricCriteria: [{ title: 'Vibe', description: 'How vibey is this proposal?' }],
        permissions: [
          { assignee: { group: 'current_reviewer' }, operation: 'comment' },
          { assignee: { group: 'author' }, operation: 'edit' }
        ],
        reviewers: [
          { group: 'role', id: role.id },
          { group: 'user', id: user.id }
        ]
      },
      {
        // The method should take the provided uuid or assign a new one automatically if missing
        id: uuid(),
        completedAt: new Date(),
        evaluationType: 'pass_fail',
        result: 'pass',
        permissions: [
          { assignee: { group: 'current_reviewer' }, operation: 'comment' },
          { assignee: { group: 'current_reviewer' }, operation: 'move' }
        ],
        reviewers: [{ group: 'role', id: role.id }]
      },
      {
        title: 'Final vote',
        evaluationType: 'vote',
        permissions: [{ assignee: { group: 'current_reviewer' }, operation: 'comment' }],
        reviewers: [{ group: 'space_member' }],
        snapshotId: uuid(),
        snapshotExpiry: new Date(),
        voteId: vote.id
      }
    ];

    const [rubricStep, passFailStep, voteStep] = evaluationSteps;

    const proposalInput: GenerateProposalInput = {
      spaceId: space.id,
      userId: user.id,
      authors: [user.id],
      proposalStatus: 'published',
      archived: true,
      customProperties,
      // These 2 fields should not be provided together. This allows us to migrate testing towards the new proposal model while maintaining retrocompatibility
      evaluationInputs: evaluationSteps
    };

    const proposal = await generateProposal({
      ...proposalPageInput,
      ...proposalInput
    });

    expect(proposal.reviewers).toMatchObject(
      expect.arrayContaining<ProposalReviewer>([
        {
          evaluationId: expect.any(String),
          id: expect.any(String),
          proposalId: proposal.id,
          roleId: role.id,
          userId: null,
          systemRole: null
        },
        {
          evaluationId: expect.any(String),
          id: expect.any(String),
          proposalId: proposal.id,
          roleId: null,
          userId: user.id,
          systemRole: null
        },
        {
          evaluationId: passFailStep.id,
          id: expect.any(String),
          proposalId: proposal.id,
          roleId: role.id,
          userId: null,
          systemRole: null
        },
        {
          evaluationId: expect.any(String),
          id: expect.any(String),
          proposalId: proposal.id,
          roleId: null,
          userId: null,
          systemRole: 'space_member'
        }
      ])
    );

    const createdEvaluationSteps = await prisma.proposalEvaluation.findMany({
      where: {
        proposalId: proposal.id
      }
    });

    expect(createdEvaluationSteps).toMatchObject(
      expect.arrayContaining<ProposalEvaluation>([
        expect.objectContaining({
          completedAt: rubricStep.completedAt as Date,
          id: expect.any(String),
          index: 0,
          proposalId: proposal.id,
          title: expect.any(String),
          type: 'rubric'
        }),
        expect.objectContaining({
          completedAt: passFailStep.completedAt as Date,
          id: passFailStep.id as string,
          index: 1,
          proposalId: proposal.id,
          result: 'pass',
          title: expect.any(String),
          type: 'pass_fail'
        }),
        expect.objectContaining({
          id: expect.any(String),
          index: 2,
          proposalId: proposal.id,
          snapshotExpiry: voteStep.snapshotExpiry as Date,
          snapshotId: voteStep.snapshotId as string,
          title: expect.any(String),
          type: 'vote',
          voteId: voteStep.voteId as string
        })
      ])
    );

    const createdRubricStep = createdEvaluationSteps.find((step) => step.type === 'rubric') as ProposalEvaluation;
    const createdPassFailStep = createdEvaluationSteps.find((step) => step.type === 'pass_fail') as ProposalEvaluation;
    const createdVoteStep = createdEvaluationSteps.find((step) => step.type === 'vote') as ProposalEvaluation;

    const createdPermissions = await prisma.proposalEvaluationPermission.findMany({
      where: {
        evaluationId: {
          in: createdEvaluationSteps.map((step) => step.id)
        }
      }
    });

    const expectedPermissionsResult: ProposalEvaluationPermission[] = [
      {
        evaluationId: createdRubricStep.id,
        id: expect.any(String),
        operation: 'comment',
        roleId: null,
        systemRole: 'current_reviewer',
        userId: null
      },
      {
        evaluationId: createdRubricStep.id,
        id: expect.any(String),
        operation: 'edit',
        roleId: null,
        systemRole: 'author',
        userId: null
      },
      {
        evaluationId: createdPassFailStep.id,
        id: expect.any(String),
        operation: 'comment',
        roleId: null,
        systemRole: 'current_reviewer',
        userId: null
      },
      {
        evaluationId: createdPassFailStep.id,
        id: expect.any(String),
        operation: 'move',
        roleId: null,
        systemRole: 'current_reviewer',
        userId: null
      },
      {
        evaluationId: createdVoteStep.id,
        id: expect.any(String),
        operation: 'comment',
        roleId: null,
        systemRole: 'current_reviewer',
        userId: null
      }
    ];

    expect(createdPermissions).toHaveLength(5);

    expect(createdPermissions).toMatchObject(
      expect.arrayContaining<ProposalEvaluationPermission>(expectedPermissionsResult)
    );

    const createdRubricCritera = await prisma.proposalRubricCriteria.findMany({
      where: {
        proposalId: proposal.id
      }
    });

    expect(createdRubricCritera).toMatchObject(
      expect.arrayContaining<ProposalRubricCriteria>([
        {
          description: rubricStep.rubricCriteria![0].description as string,
          evaluationId: createdRubricStep.id,
          id: expect.any(String),
          index: 0,
          parameters: expect.any(Object),
          proposalId: proposal.id,
          title: rubricStep.rubricCriteria![0].title as string,
          type: 'range'
        }
      ])
    );
  });

  it('should throw an error if both reviewers and evaluationInputs are provided', async () => {
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
      authors: [user.id],
      proposalStatus: 'published',
      archived: true,
      customProperties,
      // These 2 fields should not be provided together. This allows us to migrate testing towards the new proposal model while maintaining retrocompatibility
      reviewers: [],
      evaluationInputs: []
    };

    await expect(
      generateProposal({
        ...proposalPageInput,
        ...proposalInput
      })
    ).rejects.toBeInstanceOf(InvalidInputError);
  });
});
