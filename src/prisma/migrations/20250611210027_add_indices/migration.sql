-- CreateIndex
CREATE INDEX "AdditionalBlockQuota_spaceId_idx" ON "AdditionalBlockQuota"("spaceId");

-- CreateIndex
CREATE INDEX "BlacklistedUser_userId_idx" ON "BlacklistedUser"("userId");

-- CreateIndex
CREATE INDEX "CardNotification_notificationMetadataId_idx" ON "CardNotification"("notificationMetadataId");

-- CreateIndex
CREATE INDEX "CardNotification_cardId_idx" ON "CardNotification"("cardId");

-- CreateIndex
CREATE INDEX "CharmProjectCredential_userId_idx" ON "CharmProjectCredential"("userId");

-- CreateIndex
CREATE INDEX "CharmProjectCredential_projectId_idx" ON "CharmProjectCredential"("projectId");

-- CreateIndex
CREATE INDEX "CharmQualifyingEventCredential_userId_idx" ON "CharmQualifyingEventCredential"("userId");

-- CreateIndex
CREATE INDEX "CharmQualifyingEventCredential_proposalId_idx" ON "CharmQualifyingEventCredential"("proposalId");

-- CreateIndex
CREATE INDEX "CharmQualifyingEventCredential_projectId_idx" ON "CharmQualifyingEventCredential"("projectId");

-- CreateIndex
CREATE INDEX "CharmUserCredential_userId_idx" ON "CharmUserCredential"("userId");

-- CreateIndex
CREATE INDEX "CharmWallet_userId_idx" ON "CharmWallet"("userId");

-- CreateIndex
CREATE INDEX "CharmWallet_spaceId_idx" ON "CharmWallet"("spaceId");

-- CreateIndex
CREATE INDEX "CredentialTemplate_spaceId_idx" ON "CredentialTemplate"("spaceId");

-- CreateIndex
CREATE INDEX "CryptoEcosystemAuthor_login_idx" ON "CryptoEcosystemAuthor"("login");

-- CreateIndex
CREATE INDEX "CryptoEcosystemRepo_ecosystemTitle_idx" ON "CryptoEcosystemRepo"("ecosystemTitle");

-- CreateIndex
CREATE INDEX "CustomNotification_notificationMetadataId_idx" ON "CustomNotification"("notificationMetadataId");

-- CreateIndex
CREATE INDEX "DocumentNotification_pageId_idx" ON "DocumentNotification"("pageId");

-- CreateIndex
CREATE INDEX "DocumentNotification_postId_idx" ON "DocumentNotification"("postId");

-- CreateIndex
CREATE INDEX "DocumentNotification_inlineCommentId_idx" ON "DocumentNotification"("inlineCommentId");

-- CreateIndex
CREATE INDEX "DocumentNotification_postCommentId_idx" ON "DocumentNotification"("postCommentId");

-- CreateIndex
CREATE INDEX "DocumentNotification_pageCommentId_idx" ON "DocumentNotification"("pageCommentId");

-- CreateIndex
CREATE INDEX "DocumentNotification_applicationCommentId_idx" ON "DocumentNotification"("applicationCommentId");

-- CreateIndex
CREATE INDEX "DocumentNotification_notificationMetadataId_idx" ON "DocumentNotification"("notificationMetadataId");

-- CreateIndex
CREATE INDEX "DocumentSigner_documentToSignId_idx" ON "DocumentSigner"("documentToSignId");

-- CreateIndex
CREATE INDEX "DocumentSigner_completedBy_idx" ON "DocumentSigner"("completedBy");

-- CreateIndex
CREATE INDEX "DocumentToSign_spaceId_idx" ON "DocumentToSign"("spaceId");

-- CreateIndex
CREATE INDEX "DocumentToSign_proposalId_idx" ON "DocumentToSign"("proposalId");

-- CreateIndex
CREATE INDEX "DocumentToSign_evaluationId_idx" ON "DocumentToSign"("evaluationId");

-- CreateIndex
CREATE INDEX "DocusignAllowedRoleOrUser_spaceId_idx" ON "DocusignAllowedRoleOrUser"("spaceId");

-- CreateIndex
CREATE INDEX "DocusignAllowedRoleOrUser_roleId_idx" ON "DocusignAllowedRoleOrUser"("roleId");

-- CreateIndex
CREATE INDEX "DocusignAllowedRoleOrUser_userId_idx" ON "DocusignAllowedRoleOrUser"("userId");

-- CreateIndex
CREATE INDEX "DocusignCredential_userId_idx" ON "DocusignCredential"("userId");

-- CreateIndex
CREATE INDEX "DocusignCredential_spaceId_idx" ON "DocusignCredential"("spaceId");

-- CreateIndex
CREATE INDEX "FavoriteCredential_userId_idx" ON "FavoriteCredential"("userId");

-- CreateIndex
CREATE INDEX "FavoriteCredential_issuedCredentialId_idx" ON "FavoriteCredential"("issuedCredentialId");

-- CreateIndex
CREATE INDEX "GitcoinProjectAttestation_projectId_idx" ON "GitcoinProjectAttestation"("projectId");

-- CreateIndex
CREATE INDEX "IssuedCredential_credentialTemplateId_idx" ON "IssuedCredential"("credentialTemplateId");

-- CreateIndex
CREATE INDEX "IssuedCredential_proposalId_idx" ON "IssuedCredential"("proposalId");

-- CreateIndex
CREATE INDEX "IssuedCredential_rewardApplicationId_idx" ON "IssuedCredential"("rewardApplicationId");

-- CreateIndex
CREATE INDEX "IssuedCredential_userId_idx" ON "IssuedCredential"("userId");

-- CreateIndex
CREATE INDEX "OptimismProjectAttestation_projectId_idx" ON "OptimismProjectAttestation"("projectId");

-- CreateIndex
CREATE INDEX "PostNotification_notificationMetadataId_idx" ON "PostNotification"("notificationMetadataId");

-- CreateIndex
CREATE INDEX "PostNotification_postId_idx" ON "PostNotification"("postId");

-- CreateIndex
CREATE INDEX "ProductUpdatesFarcasterFrame_projectId_idx" ON "ProductUpdatesFarcasterFrame"("projectId");

-- CreateIndex
CREATE INDEX "ProjectMember_projectId_idx" ON "ProjectMember"("projectId");

-- CreateIndex
CREATE INDEX "ProposalNotification_notificationMetadataId_idx" ON "ProposalNotification"("notificationMetadataId");

-- CreateIndex
CREATE INDEX "ProposalNotification_proposalId_idx" ON "ProposalNotification"("proposalId");

-- CreateIndex
CREATE INDEX "PushNotificationSubscription_userId_idx" ON "PushNotificationSubscription"("userId");

-- CreateIndex
CREATE INDEX "SpaceSubscriptionContribution_spaceId_idx" ON "SpaceSubscriptionContribution"("spaceId");

-- CreateIndex
CREATE INDEX "SpaceSubscriptionContribution_userId_idx" ON "SpaceSubscriptionContribution"("userId");

-- CreateIndex
CREATE INDEX "SpaceSubscriptionContribution_spaceId_createdAt_idx" ON "SpaceSubscriptionContribution"("spaceId", "createdAt");

-- CreateIndex
CREATE INDEX "SpaceSubscriptionTierChangeEvent_spaceId_idx" ON "SpaceSubscriptionTierChangeEvent"("spaceId");

-- CreateIndex
CREATE INDEX "SpaceSubscriptionTierChangeEvent_spaceId_createdAt_idx" ON "SpaceSubscriptionTierChangeEvent"("spaceId", "createdAt");

-- CreateIndex
CREATE INDEX "VoteNotification_notificationMetadataId_idx" ON "VoteNotification"("notificationMetadataId");

-- CreateIndex
CREATE INDEX "VoteNotification_voteId_idx" ON "VoteNotification"("voteId");
