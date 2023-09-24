-- CreateTable
CREATE TABLE "UserNotificationMetadata" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "seenAt" TIMESTAMP(3),
    "channel" "NotificationChannel",
    "spaceId" UUID NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "UserNotificationMetadata_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BountyNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "bountyId" UUID NOT NULL,
    "applicationId" UUID,
    "type" TEXT NOT NULL,
    "mentionId" TEXT,
    "inlineCommentId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "PageNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "pageId" UUID NOT NULL,
    "mentionId" TEXT,
    "inlineCommentId" UUID NOT NULL,
    "type" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CardNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "cardId" UUID NOT NULL,
    "commentId" UUID,
    "personPropertyId" TEXT,
    "type" TEXT NOT NULL,
    "inlineCommentId" UUID NOT NULL,
    "mentionId" TEXT
);

-- CreateTable
CREATE TABLE "PostNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "commentId" UUID,
    "mentionId" TEXT,
    "type" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "ProposalNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "mentionId" TEXT,
    "inlineCommentId" UUID NOT NULL,
    "commentId" UUID
);

-- CreateTable
CREATE TABLE "VoteNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "voteId" UUID NOT NULL,
    "type" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "BountyNotification_id_key" ON "BountyNotification"("id");

-- CreateIndex
CREATE UNIQUE INDEX "PageNotification_id_key" ON "PageNotification"("id");

-- CreateIndex
CREATE UNIQUE INDEX "CardNotification_id_key" ON "CardNotification"("id");

-- CreateIndex
CREATE UNIQUE INDEX "PostNotification_id_key" ON "PostNotification"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalNotification_id_key" ON "ProposalNotification"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalNotification_proposalId_key" ON "ProposalNotification"("proposalId");

-- CreateIndex
CREATE UNIQUE INDEX "VoteNotification_id_key" ON "VoteNotification"("id");

-- AddForeignKey
ALTER TABLE "UserNotificationMetadata" ADD CONSTRAINT "UserNotificationMetadata_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserNotificationMetadata" ADD CONSTRAINT "UserNotificationMetadata_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BountyNotification" ADD CONSTRAINT "BountyNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BountyNotification" ADD CONSTRAINT "BountyNotification_bountyId_fkey" FOREIGN KEY ("bountyId") REFERENCES "Bounty"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BountyNotification" ADD CONSTRAINT "BountyNotification_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BountyNotification" ADD CONSTRAINT "BountyNotification_inlineCommentId_fkey" FOREIGN KEY ("inlineCommentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PageNotification" ADD CONSTRAINT "PageNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PageNotification" ADD CONSTRAINT "PageNotification_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "Page"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PageNotification" ADD CONSTRAINT "PageNotification_inlineCommentId_fkey" FOREIGN KEY ("inlineCommentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Block"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Block"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_inlineCommentId_fkey" FOREIGN KEY ("inlineCommentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostNotification" ADD CONSTRAINT "PostNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostNotification" ADD CONSTRAINT "PostNotification_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostNotification" ADD CONSTRAINT "PostNotification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "PostComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_inlineCommentId_fkey" FOREIGN KEY ("inlineCommentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "PageComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VoteNotification" ADD CONSTRAINT "VoteNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VoteNotification" ADD CONSTRAINT "VoteNotification_voteId_fkey" FOREIGN KEY ("voteId") REFERENCES "Vote"("id") ON DELETE CASCADE ON UPDATE CASCADE;
