/*
  Warnings:

  - A unique constraint covering the columns `[bonusEventId]` on the table `ReferralCodeEvent` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[bonusEventId,refereeId]` on the table `ReferralCodeEvent` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'referral_bonus';

-- AlterTable
ALTER TABLE "PointsReceipt" ADD COLUMN     "season" TEXT;

-- AlterTable
ALTER TABLE "ReferralCodeEvent" ADD COLUMN     "bonusEventId" UUID;

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_bonusEventId_key" ON "ReferralCodeEvent"("bonusEventId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_bonusEventId_refereeId_key" ON "ReferralCodeEvent"("bonusEventId", "refereeId");

-- AddForeignKey
ALTER TABLE "ReferralCodeEvent" ADD CONSTRAINT "ReferralCodeEvent_bonusEventId_fkey" FOREIGN KEY ("bonusEventId") REFERENCES "BuilderEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;
