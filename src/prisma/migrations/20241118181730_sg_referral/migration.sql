/*
  Warnings:

  - A unique constraint covering the columns `[referralCode]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "ReferralPlatform" AS ENUM ('telegram', 'farcaster', 'webapp', 'unknown');

-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'referral';

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "referralCode" TEXT;

-- CreateTable
CREATE TABLE "ReferralCodeEvent" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "builderEventId" UUID NOT NULL,
    "refereeId" UUID NOT NULL,
    "platform" "ReferralPlatform" NOT NULL DEFAULT 'unknown',

    CONSTRAINT "ReferralCodeEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_builderEventId_key" ON "ReferralCodeEvent"("builderEventId");

-- CreateIndex
CREATE INDEX "ReferralCodeEvent_builderEventId_idx" ON "ReferralCodeEvent"("builderEventId");

-- CreateIndex
CREATE INDEX "ReferralCodeEvent_refereeId_idx" ON "ReferralCodeEvent"("refereeId");

-- CreateIndex
CREATE UNIQUE INDEX "ReferralCodeEvent_builderEventId_refereeId_key" ON "ReferralCodeEvent"("builderEventId", "refereeId");

-- CreateIndex
CREATE UNIQUE INDEX "Scout_referralCode_key" ON "Scout"("referralCode");

-- AddForeignKey
ALTER TABLE "ReferralCodeEvent" ADD CONSTRAINT "ReferralCodeEvent_builderEventId_fkey" FOREIGN KEY ("builderEventId") REFERENCES "BuilderEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReferralCodeEvent" ADD CONSTRAINT "ReferralCodeEvent_refereeId_fkey" FOREIGN KEY ("refereeId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
