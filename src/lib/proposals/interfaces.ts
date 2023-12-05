import type {
  ProposalEvaluation,
  ProposalWorkflow,
  ProposalEvaluationPermission,
  Page,
  PageComment,
  Proposal,
  ProposalAuthor,
  ProposalReviewer
} from '@prisma/client';

import type { AssignablePermissionGroups } from '../permissions/core/interfaces';

// Workflows

export interface ProposalReviewerInput {
  group: Extract<AssignablePermissionGroups, 'role' | 'user'>;
  id: string;
}

export interface NewProposalCategory {
  title: string;
  color: string;
}

export interface ProposalCategory extends NewProposalCategory {
  id: string;
  spaceId: string;
}

export interface ProposalWithCategory extends Proposal {
  category: ProposalCategory | null;
}

export interface ProposalWithUsers extends Proposal, ProposalWithCategory {
  authors: ProposalAuthor[];
  reviewers: ProposalReviewer[];
}

export interface ProposalWithCommentsAndUsers extends ProposalWithUsers {
  page: Page & { comments: PageComment[] };
}

export type ProposalCategoryQuery = string | string[] | undefined;

/**
 * @onlyAssigned - If the user is an author or reviewer on this proposal
 */
export type ListProposalsRequest = {
  userId?: string;
  spaceId: string;
  categoryIds?: ProposalCategoryQuery;
  onlyAssigned?: boolean;
};

// Workflows - the evaluations and permissions are stored in Json for ease of use

type EvaluationPermission = Pick<ProposalEvaluationPermission, 'id' | 'operation' | 'roleId' | 'userId' | 'systemRole'>;

type EvaluationJson = Pick<ProposalEvaluation, 'id' | 'title' | 'type'> & {
  permissions: EvaluationPermission[];
};

// handle JSON types
export type ProposalWorkflowTyped = Omit<ProposalWorkflow, 'evaluations'> & {
  evaluations: EvaluationJson[];
};
