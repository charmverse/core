/*
  Warnings:

  - The values [proposal_editor] on the enum `PagePermissionLevel` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
ALTER TYPE "PageOperations" ADD VALUE 'edit_lock';

-- AlterEnum
BEGIN;
CREATE TYPE "PagePermissionLevel_new" AS ENUM ('full_access', 'editor', 'view_comment', 'view', 'custom');
ALTER TABLE "Space" ALTER COLUMN "defaultPagePermissionGroup" DROP DEFAULT;
ALTER TABLE "Space" ALTER COLUMN "defaultPagePermissionGroup" TYPE "PagePermissionLevel_new" USING ("defaultPagePermissionGroup"::text::"PagePermissionLevel_new");
ALTER TABLE "PagePermission" ALTER COLUMN "permissionLevel" TYPE "PagePermissionLevel_new" USING ("permissionLevel"::text::"PagePermissionLevel_new");
ALTER TYPE "PagePermissionLevel" RENAME TO "PagePermissionLevel_old";
ALTER TYPE "PagePermissionLevel_new" RENAME TO "PagePermissionLevel";
DROP TYPE "PagePermissionLevel_old";
ALTER TABLE "Space" ALTER COLUMN "defaultPagePermissionGroup" SET DEFAULT 'full_access';
COMMIT;

-- AlterTable
ALTER TABLE "Page" ADD COLUMN     "isLocked" BOOLEAN DEFAULT false,
ADD COLUMN     "lockedBy" UUID;
