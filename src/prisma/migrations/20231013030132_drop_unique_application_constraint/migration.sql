-- DropIndex
DROP INDEX "Application_bountyId_createdBy_key";

-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "allowMultipleApplications" BOOLEAN DEFAULT false;
