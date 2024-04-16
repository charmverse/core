/*
  Warnings:

  - The values [edit_isPublic] on the enum `PageOperations` will be removed. If these variants are still used in the database, this will fail.
  - The values [proposal_editor] on the enum `PagePermissionLevel` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "PageOperations_new" AS ENUM ('read', 'delete', 'edit_position', 'edit_content', 'edit_path', 'grant_permissions', 'comment', 'create_poll', 'delete_attached_bounty', 'edit_lock');
ALTER TABLE "PagePermission" ALTER COLUMN "permissions" TYPE "PageOperations_new"[] USING ("permissions"::text::"PageOperations_new"[]);
ALTER TYPE "PageOperations" RENAME TO "PageOperations_old";
ALTER TYPE "PageOperations_new" RENAME TO "PageOperations";
DROP TYPE "PageOperations_old";
COMMIT;

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
