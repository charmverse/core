-- CreateTable
CREATE TABLE "ProposalMyWorkColumn" (
    "spaceId" UUID NOT NULL,
    "formFieldId" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "ProposalMyWorkColumn_spaceId_formFieldId_key" ON "ProposalMyWorkColumn"("spaceId", "formFieldId");

-- AddForeignKey
ALTER TABLE "ProposalMyWorkColumn" ADD CONSTRAINT "ProposalMyWorkColumn_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalMyWorkColumn" ADD CONSTRAINT "ProposalMyWorkColumn_formFieldId_fkey" FOREIGN KEY ("formFieldId") REFERENCES "FormField"("id") ON DELETE CASCADE ON UPDATE CASCADE;
