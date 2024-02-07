/*
  Warnings:

  - You are about to drop the column `evaluationType` on the `Proposal` table. All the data in the column will be lost.
  - Made the column `evaluationId` on table `DraftProposalRubricCriteriaAnswer` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" DROP CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey";

-- AlterTable
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ALTER COLUMN "evaluationId" SET NOT NULL;

-- AlterTable
ALTER TABLE "Proposal" DROP COLUMN "evaluationType";

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
