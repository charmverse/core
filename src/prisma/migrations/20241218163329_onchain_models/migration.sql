/*
  Warnings:

  - Added the required column `walletAddress` to the `TokensReceipt` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'onchain_gems_payout';

-- AlterTable
ALTER TABLE "TokensReceipt" ADD COLUMN     "walletAddress" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "ScoutNFT" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "builderNftId" UUID NOT NULL,
    "scoutId" UUID NOT NULL,
    "balance" INTEGER NOT NULL,

    CONSTRAINT "ScoutNFT_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutNFT_builderNftId_idx" ON "ScoutNFT"("builderNftId");

-- CreateIndex
CREATE INDEX "ScoutNFT_scoutId_idx" ON "ScoutNFT"("scoutId");

-- AddForeignKey
ALTER TABLE "ScoutNFT" ADD CONSTRAINT "ScoutNFT_builderNftId_fkey" FOREIGN KEY ("builderNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutNFT" ADD CONSTRAINT "ScoutNFT_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
