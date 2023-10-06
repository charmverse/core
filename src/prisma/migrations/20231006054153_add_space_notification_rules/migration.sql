/*
  Warnings:

  - You are about to drop the column `inlineCommentId` on the `BountyNotification` table. All the data in the column will be lost.
  - You are about to drop the column `mentionId` on the `BountyNotification` table. All the data in the column will be lost.
  - You are about to drop the column `inlineCommentId` on the `ProposalNotification` table. All the data in the column will be lost.
  - You are about to drop the column `mentionId` on the `ProposalNotification` table. All the data in the column will be lost.
  - Added the required column `pageCommentId` to the `DocumentNotification` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "BountyNotification" DROP CONSTRAINT "BountyNotification_inlineCommentId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalNotification" DROP CONSTRAINT "ProposalNotification_commentId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalNotification" DROP CONSTRAINT "ProposalNotification_inlineCommentId_fkey";

-- AlterTable
ALTER TABLE "BountyNotification" DROP COLUMN "inlineCommentId",
DROP COLUMN "mentionId",
ADD COLUMN     "commentId" UUID;

-- AlterTable
ALTER TABLE "DocumentNotification" ADD COLUMN     "pageCommentId" UUID NOT NULL;

-- AlterTable
ALTER TABLE "ProposalNotification" DROP COLUMN "inlineCommentId",
DROP COLUMN "mentionId",
ADD COLUMN     "pageCommentId" UUID;

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "notificationRules" JSONB NOT NULL DEFAULT '{}';

-- AddForeignKey
ALTER TABLE "BountyNotification" ADD CONSTRAINT "BountyNotification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_pageCommentId_fkey" FOREIGN KEY ("pageCommentId") REFERENCES "PageComment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_pageCommentId_fkey" FOREIGN KEY ("pageCommentId") REFERENCES "PageComment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
