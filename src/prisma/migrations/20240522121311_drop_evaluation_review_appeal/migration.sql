/*
  Warnings:

  - You are about to drop the column `appeal` on the `ProposalEvaluationReview` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[reviewerId,evaluationId]` on the table `ProposalEvaluationReview` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "ProposalEvaluationReview_reviewerId_evaluationId_appeal_key";

-- AlterTable
ALTER TABLE "ProposalEvaluationReview" DROP COLUMN "appeal";

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluationReview_reviewerId_evaluationId_key" ON "ProposalEvaluationReview"("reviewerId", "evaluationId");
