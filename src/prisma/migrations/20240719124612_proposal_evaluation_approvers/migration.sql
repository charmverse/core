-- AlterEnum
ALTER TYPE "ProposalOperation" ADD VALUE 'complete_evaluation';

-- CreateTable
CREATE TABLE "ProposalEvaluationApprover" (
    "id" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "roleId" UUID,
    "userId" UUID,
    "systemRole" "ProposalSystemRole",
    "evaluationId" UUID NOT NULL,

    CONSTRAINT "ProposalEvaluationApprover_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalEvaluationApprover_evaluationId_idx" ON "ProposalEvaluationApprover"("evaluationId");

-- CreateIndex
CREATE INDEX "ProposalEvaluationApprover_proposalId_idx" ON "ProposalEvaluationApprover"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalEvaluationApprover_roleId_idx" ON "ProposalEvaluationApprover"("roleId");

-- CreateIndex
CREATE INDEX "ProposalEvaluationApprover_userId_idx" ON "ProposalEvaluationApprover"("userId");

-- AddForeignKey
ALTER TABLE "ProposalEvaluationApprover" ADD CONSTRAINT "ProposalEvaluationApprover_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationApprover" ADD CONSTRAINT "ProposalEvaluationApprover_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationApprover" ADD CONSTRAINT "ProposalEvaluationApprover_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalEvaluationApprover" ADD CONSTRAINT "ProposalEvaluationApprover_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
