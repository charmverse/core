-- CreateEnum
CREATE TYPE "OnchainBuilderEventType" AS ENUM ('registered', 'banned', 'unbanned');

-- AlterEnum
ALTER TYPE "ReferralPlatform" ADD VALUE 'onchain_cron';

-- AlterTable
ALTER TABLE "BuilderStrike" ADD COLUMN     "onchainStrikeAttestationUid" TEXT,
ADD COLUMN     "onchainStrikeChainId" INTEGER;

-- CreateTable
CREATE TABLE "BuilderStatusEvent" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attestationUid" UUID NOT NULL,
    "chainId" INTEGER NOT NULL,
    "status" "BuilderStatus" NOT NULL,
    "builderId" UUID NOT NULL,

    CONSTRAINT "BuilderStatusEvent_pkey" PRIMARY KEY ("attestationUid")
);

-- CreateIndex
CREATE INDEX "BuilderStatusEvent_builderId_idx" ON "BuilderStatusEvent"("builderId");

-- CreateIndex
CREATE INDEX "BuilderStatusEvent_createdAt_idx" ON "BuilderStatusEvent"("createdAt");

-- AddForeignKey
ALTER TABLE "BuilderStatusEvent" ADD CONSTRAINT "BuilderStatusEvent_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
