-- AlterEnum
ALTER TYPE "UserSpaceActionType" ADD VALUE 'app_loaded';

-- AlterTable
ALTER TABLE "UserSpaceAction" ALTER COLUMN "spaceId" DROP NOT NULL;
