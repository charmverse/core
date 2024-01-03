import type {
  Page,
  PageComment,
  Proposal,
  ProposalAuthor,
  ProposalEvaluation,
  ProposalEvaluationPermission,
  ProposalEvaluationType,
  ProposalReviewer,
  ProposalWorkflow
} from '@prisma/client';
import type { ProposalPermissionFlags } from 'lib/permissions/proposals/interfaces';

import type { AssignablePermissionGroups } from '../permissions/core/interfaces';

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
  rewardIds?: string[] | null;
}

export type ProposalWithUsersLite = ProposalWithUsers & {
  currentEvaluationId?: string;
  evaluationType: ProposalEvaluationType;
  permissions?: ProposalPermissionFlags;
  currentEvaluation?: Pick<ProposalEvaluation, 'title' | 'type'>;
};

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

type PermissionJson = Pick<ProposalEvaluationPermission, 'operation'> &
  Partial<Pick<ProposalEvaluationPermission, 'roleId' | 'userId' | 'systemRole'>>;

// we keep the id for JSON because it makes easy to manage sorting the list of evaluations in React
export type WorkflowEvaluationJson = Pick<ProposalEvaluation, 'id' | 'title' | 'type'> & {
  permissions: PermissionJson[];
};

export type ProposalWorkflowTyped = Omit<ProposalWorkflow, 'evaluations'> & {
  evaluations: WorkflowEvaluationJson[];
};
