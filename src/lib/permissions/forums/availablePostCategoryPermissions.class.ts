import { PostCategoryOperation } from '@prisma/client';

import { typedKeys } from '../../utilities/objects';
import { BasePermissions } from '../core/basePermissions.class';

const readonlyOperations: PostCategoryOperation[] = ['view_posts'];

export class AvailablePostCategoryPermissions extends BasePermissions<PostCategoryOperation> {
  constructor({ isReadonlySpace }: { isReadonlySpace: boolean }) {
    const allowedOperations = isReadonlySpace ? readonlyOperations : typedKeys(PostCategoryOperation);
    super({ allowedOperations });
  }
}
