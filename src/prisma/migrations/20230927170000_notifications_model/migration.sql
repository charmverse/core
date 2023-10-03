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
    "inlineCommentId" UUID,

    CONSTRAINT "BountyNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "pageId" UUID NOT NULL,
    "mentionId" TEXT,
    "inlineCommentId" UUID,
    "type" TEXT NOT NULL,

    CONSTRAINT "DocumentNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CardNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "cardId" UUID NOT NULL,
    "blockCommentId" UUID,
    "personPropertyId" TEXT,
    "type" TEXT NOT NULL,

    CONSTRAINT "CardNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "commentId" UUID,
    "mentionId" TEXT,
    "type" TEXT NOT NULL,

    CONSTRAINT "PostNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProposalNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "mentionId" TEXT,
    "inlineCommentId" UUID,
    "commentId" UUID,

    CONSTRAINT "ProposalNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VoteNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "voteId" UUID NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "VoteNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SQSMessage" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payload" JSONB,

    CONSTRAINT "SQSMessage_pkey" PRIMARY KEY ("id")
);

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
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "Page"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_inlineCommentId_fkey" FOREIGN KEY ("inlineCommentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Block"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_blockCommentId_fkey" FOREIGN KEY ("blockCommentId") REFERENCES "Block"("id") ON DELETE CASCADE ON UPDATE CASCADE;

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
