-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "SubscriptionTier" ADD VALUE 'bronze';
ALTER TYPE "SubscriptionTier" ADD VALUE 'silver';
ALTER TYPE "SubscriptionTier" ADD VALUE 'gold';
ALTER TYPE "SubscriptionTier" ADD VALUE 'grants';

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "subscriptionBalance" TEXT;

-- CreateTable
CREATE TABLE "SpaceSubscriptionPayment" (
    "id" UUID NOT NULL,
    "paidTokenAmount" TEXT NOT NULL,
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
    "paidTokenAmount" TEXT NOT NULL,
    "decentStatus" "DecentTxStatus" NOT NULL,
    "decentError" JSONB,
    "decentTxHash" TEXT,
    "decentChainId" INTEGER,
    "decentPayload" JSONB NOT NULL,
    "txHash" TEXT,
    "chainId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SpaceSubscriptionContribution_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionPayment" ADD CONSTRAINT "SpaceSubscriptionPayment_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionContribution" ADD CONSTRAINT "SpaceSubscriptionContribution_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionContribution" ADD CONSTRAINT "SpaceSubscriptionContribution_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
