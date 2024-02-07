/*
  Warnings:

  - Made the column `evaluationId` on table `ProposalReviewer` required. This step will fail if there are existing NULL values in that column.
  - Made the column `evaluationId` on table `ProposalRubricCriteria` required. This step will fail if there are existing NULL values in that column.
  - Made the column `evaluationId` on table `ProposalRubricCriteriaAnswer` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" DROP CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalRubricCriteria" DROP CONSTRAINT "ProposalRubricCriteria_evaluationId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" DROP CONSTRAINT "ProposalRubricCriteriaAnswer_evaluationId_fkey";

-- AlterTable
ALTER TABLE "ProposalReviewer" ALTER COLUMN "evaluationId" SET NOT NULL;

-- AlterTable
ALTER TABLE "ProposalRubricCriteria" ALTER COLUMN "evaluationId" SET NOT NULL;

-- AlterTable
ALTER TABLE "ProposalRubricCriteriaAnswer" ALTER COLUMN "evaluationId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteria" ADD CONSTRAINT "ProposalRubricCriteria_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD CONSTRAINT "ProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
