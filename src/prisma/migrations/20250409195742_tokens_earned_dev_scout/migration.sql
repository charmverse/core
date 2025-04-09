-- AlterTable
ALTER TABLE "PartnerRewardPayoutContract" ALTER COLUMN "blockNumber" DROP DEFAULT;

-- AlterTable
ALTER TABLE "UserAllTimeStats" ADD COLUMN     "tokensEarnedAsDeveloper" TEXT,
ADD COLUMN     "tokensEarnedAsScout" TEXT;

-- AlterTable
ALTER TABLE "UserSeasonStats" ADD COLUMN     "tokensEarnedAsDeveloper" TEXT,
ADD COLUMN     "tokensEarnedAsScout" TEXT;
