-- AlterEnum
ALTER TYPE "ProposalOperation" ADD VALUE 'view_evaluations';

-- AlterTable
ALTER TABLE "ProposalEvaluation" ADD COLUMN     "publishCommentsAndScores" BOOLEAN,
ADD COLUMN     "showAuthorResultsOnRubricFail" BOOLEAN;
