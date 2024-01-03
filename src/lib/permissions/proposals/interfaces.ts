import type {
  ProposalAuthor,
  ProposalCategory,
  ProposalCategoryPermissionLevel,
  ProposalReviewer
} from '@prisma/client';
import { ProposalCategoryOperation, ProposalOperation } from '@prisma/client';

import type { ProposalWithUsers } from '../../proposals/interfaces';
import { typedKeys } from '../../utilities/objects';
import type { AssignablePermissionGroups, TargetPermissionGroup, UserPermissionFlags } from '../core/interfaces';

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

export type ProposalCategoryPermissionAssignment<
  T extends AssignableProposalCategoryPermissionGroups = AssignableProposalCategoryPermissionGroups
> = {
  proposalCategoryId: string;
  permissionLevel: ProposalCategoryPermissionLevel;
  assignee: TargetPermissionGroup<T>;
};

export type AssignedProposalCategoryPermission<
  T extends AssignableProposalCategoryPermissionGroups = AssignableProposalCategoryPermissionGroups
> = ProposalCategoryPermissionAssignment<T> & {
  id: string;
};
/**
 * When returning proposal categories, also pre-compute if a user can add a proposal to that category
 */
export type ProposalCategoryWithPermissions = ProposalCategory & {
  permissions: ProposalCategoryPermissionFlags;
};
export type IsProposalReviewerFnInput = {
  proposal: Pick<ProposalWithUsers, 'id' | 'spaceId' | 'reviewers'>;
  userId?: string;
};
export type IsProposalReviewerFn = (args: IsProposalReviewerFnInput) => Promise<boolean> | boolean;

/**
 * @users - a list of user ids that can be selected to review a proposal
 * @roles - a list of role ids that can be selected to review a proposal
 *
 */
export type ProposalReviewerPool = {
  userIds: string[];
  roleIds: string[];
};
