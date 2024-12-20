/*
  Warnings:

  - You are about to drop the column `recipientId` on the `TokensReceipt` table. All the data in the column will be lost.
  - You are about to drop the column `senderId` on the `TokensReceipt` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "BuilderEvent" DROP CONSTRAINT "BuilderEvent_weeklyClaimId_fkey";

-- DropForeignKey
ALTER TABLE "TokensReceipt" DROP CONSTRAINT "TokensReceipt_recipientId_fkey";

-- DropForeignKey
ALTER TABLE "TokensReceipt" DROP CONSTRAINT "TokensReceipt_senderId_fkey";

-- DropIndex
DROP INDEX "TokensReceipt_recipientId_idx";

-- DropIndex
DROP INDEX "TokensReceipt_senderId_idx";

-- AlterTable
ALTER TABLE "TokensReceipt" DROP COLUMN "recipientId",
DROP COLUMN "senderId",
ADD COLUMN     "claimTxHash" TEXT,
ADD COLUMN     "recipientWalletAddress" TEXT,
ADD COLUMN     "senderWalletAddress" TEXT;

-- CreateTable
CREATE TABLE "ScoutNft" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "builderNftId" UUID NOT NULL,
    "walletAddress" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,

    CONSTRAINT "ScoutNft_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutNft_builderNftId_idx" ON "ScoutNft"("builderNftId");

-- CreateIndex
CREATE INDEX "ScoutNft_walletAddress_idx" ON "ScoutNft"("walletAddress");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutNft_builderNftId_walletAddress_key" ON "ScoutNft"("builderNftId", "walletAddress");

-- CreateIndex
CREATE INDEX "TokensReceipt_recipientWalletAddress_idx" ON "TokensReceipt"("recipientWalletAddress");

-- CreateIndex
CREATE INDEX "TokensReceipt_senderWalletAddress_idx" ON "TokensReceipt"("senderWalletAddress");

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_weeklyClaimId_fkey" FOREIGN KEY ("weeklyClaimId") REFERENCES "WeeklyClaims"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TokensReceipt" ADD CONSTRAINT "TokensReceipt_recipientWalletAddress_fkey" FOREIGN KEY ("recipientWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TokensReceipt" ADD CONSTRAINT "TokensReceipt_senderWalletAddress_fkey" FOREIGN KEY ("senderWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutNft" ADD CONSTRAINT "ScoutNft_builderNftId_fkey" FOREIGN KEY ("builderNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutNft" ADD CONSTRAINT "ScoutNft_walletAddress_fkey" FOREIGN KEY ("walletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
