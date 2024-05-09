-- AlterTable
ALTER TABLE "ProposalEvaluation" ADD COLUMN     "requiredReviews" INTEGER NOT NULL DEFAULT 1;

-- CreateTable
CREATE TABLE "ProposalEvaluationReview" (
    "id" UUID NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "result" "ProposalEvaluationResult" NOT NULL,
    "reviewerId" UUID NOT NULL,
    "evaluationId" UUID NOT NULL,
    "declineReasons" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "ProposalEvaluationReview_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalEvaluationReview_evaluationId_idx" ON "ProposalEvaluationReview"("evaluationId");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluationReview_reviewerId_evaluationId_key" ON "ProposalEvaluationReview"("reviewerId", "evaluationId");

-- AddForeignKey
ALTER TABLE "ProposalEvaluationReview" ADD CONSTRAINT "ProposalEvaluationReview_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationReview" ADD CONSTRAINT "ProposalEvaluationReview_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
