-- AlterEnum
ALTER TYPE "PageOperations" ADD VALUE 'edit_lock';

-- AlterTable
ALTER TABLE "Page" ADD COLUMN     "isLocked" BOOLEAN DEFAULT false,
ADD COLUMN     "lockedBy" UUID;
