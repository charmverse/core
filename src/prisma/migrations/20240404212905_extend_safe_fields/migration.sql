/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.
  - Added the required column `credentialType` to the `PendingSafeTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Page" DROP COLUMN IF EXISTS "pageId";

-- AlterTable
ALTER TABLE "PendingSafeTransaction" ADD COLUMN     "credentialType" "AttestationType" NOT NULL,
ADD COLUMN     "rewardIds" TEXT[];

-- CreateIndex
CREATE INDEX "PendingSafeTransaction_rewardIds_idx" ON "PendingSafeTransaction" USING GIN ("rewardIds");
