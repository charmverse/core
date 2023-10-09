/*
  Warnings:

  - You are about to drop the column `inlineCommentId` on the `BountyNotification` table. All the data in the column will be lost.
  - You are about to drop the column `mentionId` on the `BountyNotification` table. All the data in the column will be lost.
  - You are about to drop the column `blockCommentId` on the `CardNotification` table. All the data in the column will be lost.
  - You are about to drop the column `commentId` on the `PostNotification` table. All the data in the column will be lost.
  - You are about to drop the column `mentionId` on the `PostNotification` table. All the data in the column will be lost.
  - You are about to drop the column `commentId` on the `ProposalNotification` table. All the data in the column will be lost.
  - You are about to drop the column `inlineCommentId` on the `ProposalNotification` table. All the data in the column will be lost.
  - You are about to drop the column `mentionId` on the `ProposalNotification` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "BountyNotification" DROP CONSTRAINT "BountyNotification_inlineCommentId_fkey";

-- DropForeignKey
ALTER TABLE "CardNotification" DROP CONSTRAINT "CardNotification_blockCommentId_fkey";

-- DropForeignKey
ALTER TABLE "PostNotification" DROP CONSTRAINT "PostNotification_commentId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalNotification" DROP CONSTRAINT "ProposalNotification_commentId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalNotification" DROP CONSTRAINT "ProposalNotification_inlineCommentId_fkey";

-- AlterTable
ALTER TABLE "BountyNotification" DROP COLUMN "inlineCommentId",
DROP COLUMN "mentionId";

-- AlterTable
ALTER TABLE "CardNotification" DROP COLUMN "blockCommentId";

-- AlterTable
ALTER TABLE "DocumentNotification" ADD COLUMN     "pageCommentId" UUID,
ADD COLUMN     "postCommentId" UUID,
ADD COLUMN     "postId" UUID,
ALTER COLUMN "pageId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "PostNotification" DROP COLUMN "commentId",
DROP COLUMN "mentionId";

-- AlterTable
ALTER TABLE "ProposalNotification" DROP COLUMN "commentId",
DROP COLUMN "inlineCommentId",
DROP COLUMN "mentionId";

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_postCommentId_fkey" FOREIGN KEY ("postCommentId") REFERENCES "PostComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_pageCommentId_fkey" FOREIGN KEY ("pageCommentId") REFERENCES "PageComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
