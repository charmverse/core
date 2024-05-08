-- CreateTable
CREATE TABLE "ProposalEvaluationReview" (
    "id" UUID NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "result" "ProposalEvaluationResult" NOT NULL,
    "reviewerId" UUID NOT NULL,
    "evaluationId" UUID NOT NULL,
    "failReasons" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "ProposalEvaluationReview_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ProposalEvaluationReview" ADD CONSTRAINT "ProposalEvaluationReview_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "ProposalReviewer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationReview" ADD CONSTRAINT "ProposalEvaluationReview_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
