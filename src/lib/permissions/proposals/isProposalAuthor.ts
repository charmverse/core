import type { Proposal, ProposalAuthor } from '@prisma/client';

export function isProposalAuthor({
  userId,
  proposal
}: {
  userId?: string;
  proposal: Pick<Proposal, 'createdBy'> & { authors: ProposalAuthor[] };
}): boolean {
  if (!userId) {
    return false;
  }

  return proposal.createdBy === userId || proposal.authors.some((a) => a.userId === userId);
}
