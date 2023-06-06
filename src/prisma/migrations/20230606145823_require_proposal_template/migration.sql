-- AlterEnum
ALTER TYPE "SpaceOperation" ADD VALUE 'requireProposalTemplate';

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "requireProposalTemplate" BOOLEAN DEFAULT false;
