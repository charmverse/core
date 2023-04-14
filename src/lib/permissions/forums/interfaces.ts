import type { PostCategoryOperation, PostOperation } from '@prisma/client';

import type { UserPermissionFlags } from '../interfaces';

export type AvailablePostPermissionFlags = UserPermissionFlags<PostOperation>;
export type AvailablePostCategoryPermissionFlags = UserPermissionFlags<PostCategoryOperation>;
