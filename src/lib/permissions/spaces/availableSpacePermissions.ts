import { SpaceOperation } from '@prisma/client';

import { BasePermissions } from '../core/basePermissions.class';

export class AvailableSpacePermissions extends BasePermissions<SpaceOperation> {
  constructor() {
    super({ allowedOperations: Object.keys(SpaceOperation) as SpaceOperation[] });
  }
}
