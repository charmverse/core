-- DropIndex
DROP INDEX "Application_bountyId_createdBy_key";

-- AlterTable
ALTER TABLE "Application" ADD COLUMN     "rewardInfo" TEXT;

-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "allowMultipleApplications" BOOLEAN DEFAULT false;
