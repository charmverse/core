-- CreateEnum
CREATE TYPE "SubscriptionTier" AS ENUM ('free', 'pro', 'enterprise');

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "paidTier" "SubscriptionTier" NOT NULL DEFAULT 'pro';
