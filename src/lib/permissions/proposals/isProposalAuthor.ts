import type { Proposal } from '@prisma/client';

import type { ProposalActors } from './interfaces';

export function isProposalAuthor({
  userId,
  proposal
}: {
  userId?: string;
  proposal: Pick<Proposal, 'createdBy'> & Pick<ProposalActors, 'authors'>;
}): boolean {
  if (!userId) {
    return false;
  }

  return proposal.createdBy === userId || proposal.authors.some((a) => a.userId === userId);
}
