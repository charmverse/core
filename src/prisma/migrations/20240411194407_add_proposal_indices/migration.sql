-- CreateIndex
CREATE INDEX "Bounty_proposalId_idx" ON "Bounty"("proposalId");

-- CreateIndex
CREATE INDEX "DraftProposalRubricCriteriaAnswer_evaluationId_idx" ON "DraftProposalRubricCriteriaAnswer"("evaluationId");

-- CreateIndex
CREATE INDEX "FormField_formId_idx" ON "FormField"("formId");

-- CreateIndex
CREATE INDEX "FormFieldAnswer_proposalId_idx" ON "FormFieldAnswer"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalEvaluation_index_idx" ON "ProposalEvaluation"("index");

-- CreateIndex
CREATE INDEX "ProposalRubricCriteria_evaluationId_idx" ON "ProposalRubricCriteria"("evaluationId");

-- CreateIndex
CREATE INDEX "ProposalRubricCriteria_index_idx" ON "ProposalRubricCriteria"("index");

-- CreateIndex
CREATE INDEX "ProposalRubricCriteriaAnswer_evaluationId_idx" ON "ProposalRubricCriteriaAnswer"("evaluationId");
