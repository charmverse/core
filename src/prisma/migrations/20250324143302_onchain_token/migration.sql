/*
  Warnings:

  - You are about to drop the column `currentPriceInScoutToken` on the `BuilderNft` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "BuilderNft" DROP COLUMN "currentPriceInScoutToken",
ADD COLUMN     "currentPriceDevToken" TEXT,
ADD COLUMN     "estimatedPayoutDevToken" TEXT,
ALTER COLUMN "currentPrice" DROP NOT NULL,
ALTER COLUMN "estimatedPayout" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "currentBalanceDevToken" TEXT DEFAULT '0',
ALTER COLUMN "currentBalance" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TokensReceipt" ALTER COLUMN "value" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "WeeklyClaims" ADD COLUMN     "totalClaimableInDevToken" TEXT,
ALTER COLUMN "totalClaimable" DROP NOT NULL;
