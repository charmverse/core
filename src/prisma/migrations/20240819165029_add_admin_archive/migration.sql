-- AlterTable
ALTER TABLE "Project" ALTER COLUMN "sunnyAwardsNumber" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "archivedByAdmin" BOOLEAN DEFAULT false;
