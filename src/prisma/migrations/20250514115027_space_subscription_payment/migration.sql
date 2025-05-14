-- CreateEnum
CREATE TYPE "SpaceSubscriptionTier" AS ENUM ('readonly', 'free', 'bronze', 'silver', 'gold', 'grant');

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "subscriptionBalance" TEXT,
ADD COLUMN     "subscriptionTier" "SpaceSubscriptionTier" DEFAULT 'readonly';

-- CreateTable
CREATE TABLE "SpaceSubscriptionPayment" (
    "id" UUID NOT NULL,
    "paidTokenAmount" TEXT NOT NULL,
    "subscriptionTier" "SpaceSubscriptionTier" NOT NULL,
    "subscriptionPrice" TEXT NOT NULL,
    "subscriptionPeriodStart" TIMESTAMP(3) NOT NULL,
    "spaceId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SpaceSubscriptionPayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpaceSubscriptionContribution" (
    "id" UUID NOT NULL,
    "spaceId" UUID,
    "userId" UUID,
    "walletAddress" TEXT NOT NULL,
    "devTokenAmount" TEXT NOT NULL,
    "decentStatus" "DecentTxStatus",
    "decentError" JSONB,
    "decentTxHash" TEXT,
    "decentChainId" INTEGER,
    "decentPayload" JSONB NOT NULL,
    "txHash" TEXT,
    "chainId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SpaceSubscriptionContribution_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionPayment" ADD CONSTRAINT "SpaceSubscriptionPayment_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionContribution" ADD CONSTRAINT "SpaceSubscriptionContribution_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionContribution" ADD CONSTRAINT "SpaceSubscriptionContribution_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
