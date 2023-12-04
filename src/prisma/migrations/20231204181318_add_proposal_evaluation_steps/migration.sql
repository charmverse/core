-- CreateEnum
CREATE TYPE "ProposalEvaluationResult" AS ENUM ('pass', 'fail');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ProposalEvaluationType" ADD VALUE 'feedback';
ALTER TYPE "ProposalEvaluationType" ADD VALUE 'pass_fail';

-- AlterEnum
ALTER TYPE "ProposalStatus" ADD VALUE 'published';

-- AlterTable
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalReviewer" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalRubricCriteria" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD COLUMN     "evaluationId" UUID;

-- CreateTable
CREATE TABLE "ProposalEvaluationWorkflow" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "evaluations" JSONB[],

    CONSTRAINT "ProposalEvaluationWorkflow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProposalEvaluation" (
    "id" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "type" "ProposalEvaluationType" NOT NULL,
    "result" "ProposalEvaluationResult",
    "completedAt" TIMESTAMP(3),
    "snapshotId" TEXT,
    "snapshotExpiry" TIMESTAMP(3),
    "voteId" UUID,

    CONSTRAINT "ProposalEvaluation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluation_voteId_key" ON "ProposalEvaluation"("voteId");

-- AddForeignKey
ALTER TABLE "ProposalEvaluationWorkflow" ADD CONSTRAINT "ProposalEvaluationWorkflow_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

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
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
