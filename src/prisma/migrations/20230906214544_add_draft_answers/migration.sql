-- CreateTable
CREATE TABLE "DraftProposalRubricCriteriaAnswer" (
    "rubricCriteriaId" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "userId" TEXT NOT NULL,
    "response" JSONB NOT NULL,
    "comment" TEXT
);

-- CreateIndex
CREATE INDEX "DraftProposalRubricCriteriaAnswer_proposalId_idx" ON "DraftProposalRubricCriteriaAnswer"("proposalId");

-- CreateIndex
CREATE INDEX "DraftProposalRubricCriteriaAnswer_rubricCriteriaId_idx" ON "DraftProposalRubricCriteriaAnswer"("rubricCriteriaId");

-- CreateIndex
CREATE UNIQUE INDEX "DraftProposalRubricCriteriaAnswer_userId_rubricCriteriaId_key" ON "DraftProposalRubricCriteriaAnswer"("userId", "rubricCriteriaId");

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_rubricCriteriaId_fkey" FOREIGN KEY ("rubricCriteriaId") REFERENCES "ProposalRubricCriteria"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftProposalRubricCriteriaAnswer" ADD CONSTRAINT "DraftProposalRubricCriteriaAnswer_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;
