-- AlterTable
ALTER TABLE "Block" ADD COLUMN     "isLocked" BOOLEAN;

-- AlterTable
ALTER TABLE "ProposalBlock" ADD COLUMN     "isLocked" BOOLEAN;

-- AlterTable
ALTER TABLE "RewardBlock" ADD COLUMN     "isLocked" BOOLEAN;
