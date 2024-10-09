-- CreateTable
CREATE TABLE "ProposalMyTaskColumn" (
    "spaceId" UUID NOT NULL,
    "formFieldId" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "ProposalMyTaskColumn_spaceId_formFieldId_key" ON "ProposalMyTaskColumn"("spaceId", "formFieldId");

-- AddForeignKey
ALTER TABLE "ProposalMyTaskColumn" ADD CONSTRAINT "ProposalMyTaskColumn_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalMyTaskColumn" ADD CONSTRAINT "ProposalMyTaskColumn_formFieldId_fkey" FOREIGN KEY ("formFieldId") REFERENCES "FormField"("id") ON DELETE CASCADE ON UPDATE CASCADE;
