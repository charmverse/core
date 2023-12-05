/*
  Warnings:

  - You are about to drop the column `proposalOperations` on the `ProposalCategoryPermission` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "ProposalEvaluationResult" AS ENUM ('pass', 'fail');

-- CreateEnum
CREATE TYPE "ProposalSystemRole" AS ENUM ('author', 'space_member', 'current_reviewer', 'all_reviewers');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ProposalEvaluationType" ADD VALUE 'feedback';
ALTER TYPE "ProposalEvaluationType" ADD VALUE 'pass_fail';

-- AlterEnum
ALTER TYPE "ProposalOperation" ADD VALUE 'move';

-- AlterEnum
ALTER TYPE "ProposalStatus" ADD VALUE 'published';

-- AlterTable
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "workflowId" UUID;

-- AlterTable
ALTER TABLE "ProposalCategoryPermission" DROP COLUMN "proposalOperations";

-- AlterTable
ALTER TABLE "ProposalReviewer" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalRubricCriteria" ADD COLUMN     "evaluationId" UUID;

-- AlterTable
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD COLUMN     "evaluationId" UUID;

-- CreateTable
CREATE TABLE "ProposalWorkflow" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "spaceId" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "evaluations" JSONB[],

    CONSTRAINT "ProposalWorkflow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProposalEvaluationPermission" (
    "id" UUID NOT NULL,
    "operation" "ProposalOperation" NOT NULL,
    "evaluationId" UUID NOT NULL,
    "roleId" UUID,
    "userId" UUID,
    "systemRole" "ProposalSystemRole",

    CONSTRAINT "ProposalEvaluationPermission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProposalEvaluation" (
    "id" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "type" "ProposalEvaluationType" NOT NULL,
    "completedAt" TIMESTAMP(3),
    "snapshotId" TEXT,
    "snapshotExpiry" TIMESTAMP(3),
    "proposalId" UUID NOT NULL,
    "voteId" UUID,
    "result" "ProposalEvaluationResult",

    CONSTRAINT "ProposalEvaluation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalWorkflow_spaceId_idx" ON "ProposalWorkflow"("spaceId");

-- CreateIndex
CREATE INDEX "ProposalEvaluationPermission_evaluationId_idx" ON "ProposalEvaluationPermission"("evaluationId");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalEvaluation_voteId_key" ON "ProposalEvaluation"("voteId");

-- CreateIndex
CREATE INDEX "ProposalEvaluation_proposalId_idx" ON "ProposalEvaluation"("proposalId");

-- AddForeignKey
ALTER TABLE "Proposal" ADD CONSTRAINT "Proposal_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "ProposalWorkflow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalWorkflow" ADD CONSTRAINT "ProposalWorkflow_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationPermission" ADD CONSTRAINT "ProposalEvaluationPermission_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationPermission" ADD CONSTRAINT "ProposalEvaluationPermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationPermission" ADD CONSTRAINT "ProposalEvaluationPermission_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluation" ADD CONSTRAINT "ProposalEvaluation_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluation" ADD CONSTRAINT "ProposalEvaluation_voteId_fkey" FOREIGN KEY ("voteId") REFERENCES "Vote"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalReviewer" ADD CONSTRAINT "ProposalReviewer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteria" ADD CONSTRAINT "ProposalRubricCriteria_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD CONSTRAINT "ProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
