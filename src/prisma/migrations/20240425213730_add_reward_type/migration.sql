-- CreateEnum
CREATE TYPE "RewardType" AS ENUM ('token', 'none', 'custom');

-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "rewardType" "RewardType" NOT NULL DEFAULT 'none';
