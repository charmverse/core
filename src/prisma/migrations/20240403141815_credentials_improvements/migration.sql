/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userId,credentialTemplateId,credentialEvent,proposalId,rewardApplicationId]` on the table `IssuedCredential` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Page" DROP COLUMN "pageId";

-- AlterTable
ALTER TABLE "PendingSafeTransaction" ADD COLUMN     "rewardIds" TEXT[];

-- CreateIndex
CREATE UNIQUE INDEX "IssuedCredential_userId_credentialTemplateId_credentialEven_key" ON "IssuedCredential"("userId", "credentialTemplateId", "credentialEvent", "proposalId", "rewardApplicationId");

-- CreateIndex
CREATE INDEX "PendingSafeTransaction_rewardIds_idx" ON "PendingSafeTransaction" USING GIN ("rewardIds");
