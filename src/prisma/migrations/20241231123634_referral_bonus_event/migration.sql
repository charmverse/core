/*
  Warnings:

  - A unique constraint covering the columns `[bonusBuilderEventId]` on the table `ReferralCodeEvent` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[bonusBuilderEventId,refereeId]` on the table `ReferralCodeEvent` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'referral_bonus';

-- AlterTable
ALTER TABLE "ReferralCodeEvent" ADD COLUMN     "bonusBuilderEventId" UUID;

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_bonusBuilderEventId_key" ON "ReferralCodeEvent"("bonusBuilderEventId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_bonusBuilderEventId_refereeId_key" ON "ReferralCodeEvent"("bonusBuilderEventId", "refereeId");

-- AddForeignKey
ALTER TABLE "ReferralCodeEvent" ADD CONSTRAINT "ReferralCodeEvent_bonusBuilderEventId_fkey" FOREIGN KEY ("bonusBuilderEventId") REFERENCES "BuilderEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;
