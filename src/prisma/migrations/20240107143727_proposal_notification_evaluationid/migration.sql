-- AlterTable
ALTER TABLE "ProposalNotification" ADD COLUMN     "evaluationId" UUID;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
