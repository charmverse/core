-- AlterTable
ALTER TABLE "BuilderNft" ADD COLUMN     "estimatedPayoutInScoutToken" TEXT,
ALTER COLUMN "currentPrice" DROP NOT NULL,
ALTER COLUMN "estimatedPayout" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "currentBalanceInScoutToken" TEXT DEFAULT '0',
ALTER COLUMN "currentBalance" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TokensReceipt" ALTER COLUMN "value" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "WeeklyClaims" ADD COLUMN     "totalClaimableInScoutToken" TEXT,
ALTER COLUMN "totalClaimable" DROP NOT NULL;
