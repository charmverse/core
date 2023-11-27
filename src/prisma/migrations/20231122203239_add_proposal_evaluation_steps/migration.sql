-- CreateEnum
CREATE TYPE "ProposalEvaluationResult" AS ENUM ('pass', 'fail');

-- AlterEnum
ALTER TYPE "ProposalStatus" ADD VALUE 'published';

-- AlterTable
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD COLUMN     "proposalEvaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalReviewer" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalRubricCriteria" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD COLUMN     "evaluationId" UUID;

-- CreateTable
CREATE TABLE "ProposalEvaluation" (
    "id" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "evaluationType" "ProposalEvaluationType" NOT NULL DEFAULT 'vote',
    "result" "ProposalEvaluationResult",
    "snapshotId" TEXT,
    "snapshotExpiry" TIMESTAMP(3),
    "voteId" UUID,

    CONSTRAINT "ProposalEvaluation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluation_voteId_key" ON "ProposalEvaluation"("voteId");

-- AddForeignKey
ALTER TABLE "ProposalEvaluation" ADD CONSTRAINT "ProposalEvaluation_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluation" ADD CONSTRAINT "ProposalEvaluation_voteId_fkey" FOREIGN KEY ("voteId") REFERENCES "Vote"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalReviewer" ADD CONSTRAINT "ProposalReviewer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteria" ADD CONSTRAINT "ProposalRubricCriteria_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD CONSTRAINT "ProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_proposalEvaluationId_fkey" FOREIGN KEY ("proposalEvaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
