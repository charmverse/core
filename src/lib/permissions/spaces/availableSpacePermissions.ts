import { SpaceOperation } from '../../../prisma';
import { BasePermissions } from '../core/basePermissions.class';

export class AvailableSpacePermissions extends BasePermissions<SpaceOperation> {
  constructor(operations: SpaceOperation[] = []) {
    super({ allowedOperations: Object.keys(SpaceOperation) as SpaceOperation[] });

    this.addPermissions(operations);
  }
}
