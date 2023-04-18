import { PostOperation } from '@prisma/client';

import { typedKeys } from '../../utilities/objects';
import { BasePermissions } from '../core/basePermissions.class';

export class AvailablePostPermissions extends BasePermissions<PostOperation> {
  constructor() {
    super({ allowedOperations: typedKeys(PostOperation) });
  }
}
