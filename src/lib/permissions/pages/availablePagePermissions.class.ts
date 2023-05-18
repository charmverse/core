import { PageOperations } from '@prisma/client';

import { typedKeys } from '../../utilities/objects';
import { BasePermissions } from '../core/basePermissions.class';

/**
 * Provides a set of page permissions
 *
 * Permissions can be added, but not removed.
 */
export class AvailablePagePermissions extends BasePermissions<PageOperations> {
  constructor() {
    super({
      allowedOperations: typedKeys(PageOperations)
    });
  }
}
