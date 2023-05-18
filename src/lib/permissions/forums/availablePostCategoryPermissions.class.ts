import { PostCategoryOperation } from '../../../prisma';
import { typedKeys } from '../../utilities/objects';
import { BasePermissions } from '../core/basePermissions.class';

export class AvailablePostCategoryPermissions extends BasePermissions<PostCategoryOperation> {
  constructor() {
    super({ allowedOperations: typedKeys(PostCategoryOperation) });
  }
}
