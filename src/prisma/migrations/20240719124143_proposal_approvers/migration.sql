-- AlterEnum
ALTER TYPE "ProposalOperation" ADD VALUE 'complete_evaluation';

-- CreateTable
CREATE TABLE "ProposalApprover" (
    "id" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "roleId" UUID,
    "userId" UUID,
    "systemRole" "ProposalSystemRole",
    "evaluationId" UUID NOT NULL,

    CONSTRAINT "ProposalApprover_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalApprover_evaluationId_idx" ON "ProposalApprover"("evaluationId");

-- CreateIndex
CREATE INDEX "ProposalApprover_proposalId_idx" ON "ProposalApprover"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalApprover_roleId_idx" ON "ProposalApprover"("roleId");

-- CreateIndex
CREATE INDEX "ProposalApprover_userId_idx" ON "ProposalApprover"("userId");

-- AddForeignKey
ALTER TABLE "ProposalApprover" ADD CONSTRAINT "ProposalApprover_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalApprover" ADD CONSTRAINT "ProposalApprover_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalApprover" ADD CONSTRAINT "ProposalApprover_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalApprover" ADD CONSTRAINT "ProposalApprover_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
