-- CreateEnum
CREATE TYPE "ProposalFormFieldType" AS ENUM ('text', 'text_multiline', 'number', 'email', 'phone', 'url', 'select', 'multiselect', 'wallet', 'date', 'person', 'label');

-- CreateTable
CREATE TABLE "ProposalFormField" (
    "id" UUID NOT NULL,
    "type" "ProposalFormFieldType" NOT NULL,
    "index" INTEGER NOT NULL DEFAULT -1,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "required" BOOLEAN NOT NULL DEFAULT false,
    "private" BOOLEAN NOT NULL DEFAULT false,
    "proposalId" UUID NOT NULL,
    "options" JSONB,
    "parentFieldId" UUID,

    CONSTRAINT "ProposalFormField_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProposalFormFieldValue" (
    "id" UUID NOT NULL,
    "fieldId" UUID NOT NULL,
    "value" JSONB NOT NULL,

    CONSTRAINT "ProposalFormFieldValue_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalFormField_proposalId_idx" ON "ProposalFormField"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalFormFieldValue_fieldId_idx" ON "ProposalFormFieldValue"("fieldId");

-- AddForeignKey
ALTER TABLE "ProposalFormField" ADD CONSTRAINT "ProposalFormField_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalFormField" ADD CONSTRAINT "ProposalFormField_parentFieldId_fkey" FOREIGN KEY ("parentFieldId") REFERENCES "ProposalFormField"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalFormFieldValue" ADD CONSTRAINT "ProposalFormFieldValue_fieldId_fkey" FOREIGN KEY ("fieldId") REFERENCES "ProposalFormField"("id") ON DELETE CASCADE ON UPDATE CASCADE;
