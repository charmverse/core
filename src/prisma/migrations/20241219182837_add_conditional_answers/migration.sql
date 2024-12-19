-- AlterTable
ALTER TABLE "FormFieldAnswer" ADD COLUMN     "dependsOnEvaluationId" UUID;

-- AddForeignKey
ALTER TABLE "FormFieldAnswer" ADD CONSTRAINT "FormFieldAnswer_dependsOnEvaluationId_fkey" FOREIGN KEY ("dependsOnEvaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
