-- AlterTable
ALTER TABLE "ProposalEvaluation" ADD COLUMN     "failReasons" TEXT[] DEFAULT ARRAY[]::TEXT[];
