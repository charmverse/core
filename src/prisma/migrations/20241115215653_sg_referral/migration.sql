/*
  Warnings:

  - A unique constraint covering the columns `[referralCode]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "ReferralPlatform" AS ENUM ('telegram', 'webapp', 'unknown');

-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'referral';

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "referralCode" TEXT;

-- CreateTable
CREATE TABLE "ReferralCodeEvent" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "referrerId" UUID NOT NULL,
    "refereeId" UUID NOT NULL,
    "platform" "ReferralPlatform" NOT NULL DEFAULT 'webapp',

    CONSTRAINT "ReferralCodeEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ReferralCodeEvent_referrerId_idx" ON "ReferralCodeEvent"("referrerId");

-- CreateIndex
CREATE INDEX "ReferralCodeEvent_refereeId_idx" ON "ReferralCodeEvent"("refereeId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_referrerId_refereeId_key" ON "ReferralCodeEvent"("referrerId", "refereeId");

-- CreateIndex
CREATE UNIQUE INDEX "Scout_referralCode_key" ON "Scout"("referralCode");

-- AddForeignKey
ALTER TABLE "ReferralCodeEvent" ADD CONSTRAINT "ReferralCodeEvent_referrerId_fkey" FOREIGN KEY ("referrerId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReferralCodeEvent" ADD CONSTRAINT "ReferralCodeEvent_refereeId_fkey" FOREIGN KEY ("refereeId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
