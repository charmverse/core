/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Page" DROP COLUMN "pageId";

-- AlterTable
ALTER TABLE "PendingSafeTransaction" ADD COLUMN     "rewardIds" TEXT[];

-- CreateIndex
CREATE INDEX "PendingSafeTransaction_rewardIds_idx" ON "PendingSafeTransaction" USING GIN ("rewardIds");
