-- AlterEnum
ALTER TYPE "ProposalSystemRole" ADD VALUE 'public';

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "makeRewardsPublic" BOOLEAN DEFAULT false;
