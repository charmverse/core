import { ProposalCategoryOperation, ProposalOperation } from '@prisma/client';
import type {
  ProposalCategory,
  ProposalCategoryPermissionLevel,
  ProposalAuthor,
  ProposalReviewer
} from '@prisma/client';
import { typedKeys } from 'lib/utilities/objects';

import type { AssignablePermissionGroups, TargetPermissionGroup, UserPermissionFlags } from '../interfaces';

export type ProposalActors = {
  authors: ProposalAuthor[];
  reviewers: ProposalReviewer[];
};

export type AssignableProposalCategoryPermissionGroups = Extract<
  AssignablePermissionGroups,
  'role' | 'space' | 'public'
>;

export const proposalCategoryPermissionGroups: AssignableProposalCategoryPermissionGroups[] = [
  'role',
  'space',
  'public'
];

export const proposalOperations = [...typedKeys(ProposalOperation)] as const;
export const proposalCategoryOperations = [...typedKeys(ProposalCategoryOperation)] as const;

export type ProposalPermissionFlags = UserPermissionFlags<ProposalOperation>;
export type ProposalCategoryPermissionFlags = UserPermissionFlags<ProposalCategoryOperation>;

export type AssignedProposalCategoryPermission<
  T extends AssignableProposalCategoryPermissionGroups = AssignableProposalCategoryPermissionGroups
> = {
  id: string;
  proposalCategoryId: string;
  permissionLevel: ProposalCategoryPermissionLevel;
  assignee: TargetPermissionGroup<T>;
};
/**
 * When returning proposal categories, also pre-compute if a user can add a proposal to that category
 */
export type ProposalCategoryWithPermissions = ProposalCategory & {
  permissions: ProposalCategoryPermissionFlags;
};
export type IsProposalReviewerFnInput = { proposal: ProposalActors; userId?: string };
export type IsProposalReviewerFn = (args: IsProposalReviewerFnInput) => Promise<boolean> | boolean;
