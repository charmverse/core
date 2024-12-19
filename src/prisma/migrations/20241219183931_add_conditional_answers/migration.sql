-- AlterTable
ALTER TABLE "FormField" ADD COLUMN     "dependsOnEvaluationId" UUID;

-- AddForeignKey
ALTER TABLE "FormField" ADD CONSTRAINT "FormField_dependsOnEvaluationId_fkey" FOREIGN KEY ("dependsOnEvaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
