/*
  Warnings:

  - You are about to drop the column `proposalOperations` on the `ProposalCategoryPermission` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "ProposalSystemRole" AS ENUM ('author', 'space_member', 'current_reviewer', 'all_reviewers');

-- AlterEnum
ALTER TYPE "ProposalOperation" ADD VALUE 'move';

-- DropForeignKey
ALTER TABLE "ProposalEvaluation" DROP CONSTRAINT "ProposalEvaluation_voteId_fkey";

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "evaluationWorkflowId" UUID;

-- AlterTable
ALTER TABLE "ProposalCategoryPermission" DROP COLUMN "proposalOperations";

-- AlterTable
ALTER TABLE "ProposalEvaluationWorkflow" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

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

-- CreateIndex
CREATE INDEX "ProposalEvaluationPermission_evaluationId_idx" ON "ProposalEvaluationPermission"("evaluationId");

-- CreateIndex
CREATE INDEX "ProposalEvaluation_proposalId_idx" ON "ProposalEvaluation"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalEvaluationWorkflow_spaceId_idx" ON "ProposalEvaluationWorkflow"("spaceId");

-- AddForeignKey
ALTER TABLE "Proposal" ADD CONSTRAINT "Proposal_evaluationWorkflowId_fkey" FOREIGN KEY ("evaluationWorkflowId") REFERENCES "ProposalEvaluationWorkflow"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationPermission" ADD CONSTRAINT "ProposalEvaluationPermission_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationPermission" ADD CONSTRAINT "ProposalEvaluationPermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationPermission" ADD CONSTRAINT "ProposalEvaluationPermission_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluation" ADD CONSTRAINT "ProposalEvaluation_voteId_fkey" FOREIGN KEY ("voteId") REFERENCES "Vote"("id") ON DELETE SET NULL ON UPDATE CASCADE;
