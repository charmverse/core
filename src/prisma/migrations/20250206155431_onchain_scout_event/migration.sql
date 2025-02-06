-- CreateEnum
CREATE TYPE "OnchainBuilderEventType" AS ENUM ('registered', 'banned', 'unbanned');

-- AlterEnum
ALTER TYPE "ReferralPlatform" ADD VALUE 'onchain_cron';

-- AlterTable
ALTER TABLE "BuilderStrike" ADD COLUMN     "onchainStrikeAttestationUid" TEXT,
ADD COLUMN     "onchainStrikeChainId" INTEGER;

-- CreateTable
CREATE TABLE "OnchainBuilderEvent" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "onchainAttestationUid" UUID NOT NULL,
    "onchainChainId" INTEGER NOT NULL,
    "type" "OnchainBuilderEventType" NOT NULL,
    "builderId" UUID NOT NULL,

    CONSTRAINT "OnchainBuilderEvent_pkey" PRIMARY KEY ("onchainAttestationUid")
);

-- AddForeignKey
ALTER TABLE "OnchainBuilderEvent" ADD CONSTRAINT "OnchainBuilderEvent_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
