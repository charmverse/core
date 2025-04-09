-- CreateEnum
CREATE TYPE "PartnerRewardPayoutContractProvider" AS ENUM ('thirdweb', 'sablier');

-- AlterTable
ALTER TABLE "PartnerRewardPayoutContract" ADD COLUMN     "provider" "PartnerRewardPayoutContractProvider" NOT NULL DEFAULT 'sablier';
