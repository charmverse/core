import type { IsProposalReviewerFnInput } from './interfaces';

export function isProposalReviewer({ proposal, userId }: IsProposalReviewerFnInput): boolean {
  return !!userId && proposal.reviewers.some((r) => r.userId === userId);
}
