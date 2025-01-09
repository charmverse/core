/*
  Warnings:

  - A unique constraint covering the columns `[proposalId,fieldId]` on the table `FormFieldAnswer` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "FormFieldAnswer" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE UNIQUE INDEX "FormFieldAnswer_proposalId_fieldId_key" ON "FormFieldAnswer"("proposalId", "fieldId");
