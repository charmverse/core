-- AlterEnum
ALTER TYPE "ProposalEvaluationType" ADD VALUE 'private_evaluation';

-- AlterTable
ALTER TABLE "ProposalWorkflow" ADD COLUMN     "privateEvaluations" BOOLEAN DEFAULT false;
