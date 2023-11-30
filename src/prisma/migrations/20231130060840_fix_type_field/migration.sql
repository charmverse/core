/*
  Warnings:

  - You are about to drop the column `proposalEvaluationId` on the `DraftProposalRubricCriteriaAnswer` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" DROP CONSTRAINT "DraftProposalRubricCriteriaAnswer_proposalEvaluationId_fkey";

-- AlterTable
ALTER TABLE "DraftProposalRubricCriteriaAnswer" DROP COLUMN "proposalEvaluationId",
ADD COLUMN     "evaluationId" UUID;

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
