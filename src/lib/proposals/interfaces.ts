import type {
  Page,
  PageComment,
  Proposal,
  ProposalAuthor,
  ProposalEvaluation,
  ProposalEvaluationPermission,
  ProposalReviewer,
  ProposalWorkflow
} from '@prisma/client';

export type ProposalReviewerInput = Partial<Pick<ProposalReviewer, 'userId' | 'roleId' | 'systemRole'>>;

export interface ProposalWithUsers extends Proposal {
  authors: ProposalAuthor[];
  reviewers: ProposalReviewer[];
  rewardIds?: string[] | null;
}

export interface ProposalWithCommentsAndUsers extends ProposalWithUsers {
  page: Page & { comments: PageComment[] };
}

/**
 * @onlyAssigned - If the user is an author or reviewer on this proposal
 */
export type ListProposalsRequest = {
  userId?: string;
  spaceId: string;
  onlyAssigned?: boolean;
};

// Workflows - the evaluations and permissions are stored in Json for ease of use

export type PermissionJson = Pick<ProposalEvaluationPermission, 'operation'> &
  Partial<Pick<ProposalEvaluationPermission, 'roleId' | 'userId' | 'systemRole'>>;

// we keep the id for JSON because it makes easy to manage sorting the list of evaluations in React
export type WorkflowEvaluationJson = Pick<ProposalEvaluation, 'id' | 'title' | 'type'> & {
  permissions: PermissionJson[];
};

export type ProposalWorkflowTyped = Omit<ProposalWorkflow, 'evaluations'> & {
  evaluations: WorkflowEvaluationJson[];
};
