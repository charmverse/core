-- CreateEnum
CREATE TYPE "PartnerRewardPayoutContractProvider" AS ENUM ('thirdweb', 'sablier');

-- AlterTable
ALTER TABLE "PartnerRewardPayoutContract" ADD COLUMN     "blockNumber" BIGINT NOT NULL DEFAULT 0,
ADD COLUMN     "provider" "PartnerRewardPayoutContractProvider" NOT NULL DEFAULT 'sablier';
