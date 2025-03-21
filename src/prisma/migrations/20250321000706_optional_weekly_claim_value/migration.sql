-- AlterTable
ALTER TABLE "BuilderNft" ALTER COLUMN "currentPrice" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TokensReceipt" ALTER COLUMN "value" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "WeeklyClaims" ADD COLUMN     "totalClaimableInScoutToken" TEXT,
ALTER COLUMN "totalClaimable" DROP NOT NULL;
