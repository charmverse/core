/*
  Warnings:

  - A unique constraint covering the columns `[reviewerId,evaluationId,appeal]` on the table `ProposalEvaluationReview` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "ProposalEvaluationReview_reviewerId_evaluationId_key";

-- AlterTable
ALTER TABLE "ProposalEvaluation" ADD COLUMN     "appealRequiredReviews" INTEGER,
ADD COLUMN     "appealable" BOOLEAN DEFAULT false,
ADD COLUMN     "appealedAt" TIMESTAMP(3),
ADD COLUMN     "appealedBy" UUID,
ADD COLUMN     "declinedAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "ProposalEvaluationReview" ADD COLUMN     "appeal" BOOLEAN;

-- CreateTable
CREATE TABLE "ProposalAppealReviewer" (
    "id" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "roleId" UUID,
    "userId" UUID,
    "evaluationId" UUID NOT NULL,

    CONSTRAINT "ProposalAppealReviewer_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalAppealReviewer_evaluationId_idx" ON "ProposalAppealReviewer"("evaluationId");

-- CreateIndex
CREATE INDEX "ProposalAppealReviewer_proposalId_idx" ON "ProposalAppealReviewer"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalAppealReviewer_roleId_idx" ON "ProposalAppealReviewer"("roleId");

-- CreateIndex
CREATE INDEX "ProposalAppealReviewer_userId_idx" ON "ProposalAppealReviewer"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluationReview_reviewerId_evaluationId_appeal_key" ON "ProposalEvaluationReview"("reviewerId", "evaluationId", "appeal");

-- AddForeignKey
ALTER TABLE "ProposalEvaluation" ADD CONSTRAINT "ProposalEvaluation_appealedBy_fkey" FOREIGN KEY ("appealedBy") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalAppealReviewer" ADD CONSTRAINT "ProposalAppealReviewer_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalAppealReviewer" ADD CONSTRAINT "ProposalAppealReviewer_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalAppealReviewer" ADD CONSTRAINT "ProposalAppealReviewer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalAppealReviewer" ADD CONSTRAINT "ProposalAppealReviewer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
