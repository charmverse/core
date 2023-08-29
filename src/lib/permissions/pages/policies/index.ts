import type { PageResource } from './interfaces';
import { policyConvertedToProposal } from './policyConvertedToProposal';

export const defaultPagePolicies = [policyConvertedToProposal];

// Used for db queries to ensure consistent shape
export function pageResourceSelect(): Record<keyof PageResource, true> {
  return {
    id: true,
    createdBy: true,
    spaceId: true,
    proposalId: true,
    convertedProposalId: true,
    bounty: true,
    type: true
  };
}

export * from './interfaces';
export * from './resolver';
