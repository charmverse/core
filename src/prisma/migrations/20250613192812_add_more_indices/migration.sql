-- CreateIndex
CREATE INDEX "Post_createdBy_idx" ON "Post"("createdBy");

-- CreateIndex
CREATE INDEX "Post_proposalId_idx" ON "Post"("proposalId");

-- CreateIndex
CREATE INDEX "Proposal_workflowId_idx" ON "Proposal"("workflowId");

-- CreateIndex
CREATE INDEX "Proposal_projectId_idx" ON "Proposal"("projectId");

-- CreateIndex
CREATE INDEX "Proposal_formId_idx" ON "Proposal"("formId");

-- CreateIndex
CREATE INDEX "Proposal_archived_idx" ON "Proposal"("archived");

-- CreateIndex
CREATE INDEX "Proposal_status_idx" ON "Proposal"("status");

-- CreateIndex
CREATE INDEX "Space_homePageId_idx" ON "Space"("homePageId");

-- CreateIndex
CREATE INDEX "Space_defaultPostCategoryId_idx" ON "Space"("defaultPostCategoryId");

-- CreateIndex
CREATE INDEX "Space_domain_idx" ON "Space"("domain");

-- CreateIndex
CREATE INDEX "Space_customDomain_idx" ON "Space"("customDomain");

-- CreateIndex
CREATE INDEX "Space_name_idx" ON "Space"("name");

-- CreateIndex
CREATE INDEX "UserNotificationMetadata_spaceId_idx" ON "UserNotificationMetadata"("spaceId");

-- CreateIndex
CREATE INDEX "UserNotificationMetadata_createdBy_idx" ON "UserNotificationMetadata"("createdBy");

-- CreateIndex
CREATE INDEX "UserNotificationMetadata_userId_idx" ON "UserNotificationMetadata"("userId");

-- CreateIndex
CREATE INDEX "UserSpaceAction_pageId_idx" ON "UserSpaceAction"("pageId");

-- CreateIndex
CREATE INDEX "UserSpaceAction_postId_idx" ON "UserSpaceAction"("postId");
