-- CreateTable
CREATE TABLE "ProposalEvaluationAppealReview" (
    "id" UUID NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "result" "ProposalEvaluationResult" NOT NULL,
    "reviewerId" UUID NOT NULL,
    "evaluationId" UUID NOT NULL,
    "declineReasons" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "ProposalEvaluationAppealReview_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalEvaluationAppealReview_evaluationId_idx" ON "ProposalEvaluationAppealReview"("evaluationId");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluationAppealReview_reviewerId_evaluationId_key" ON "ProposalEvaluationAppealReview"("reviewerId", "evaluationId");

-- AddForeignKey
ALTER TABLE "ProposalEvaluationAppealReview" ADD CONSTRAINT "ProposalEvaluationAppealReview_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationAppealReview" ADD CONSTRAINT "ProposalEvaluationAppealReview_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
