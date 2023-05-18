import type { Page, PageComment, Proposal, ProposalAuthor, ProposalReviewer } from '../../prisma';
import type { AssignablePermissionGroups } from '../permissions/interfaces';

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
  includePage?: boolean;
  userId?: string;
  spaceId: string;
  categoryIds?: ProposalCategoryQuery;
  onlyAssigned?: boolean;
};
