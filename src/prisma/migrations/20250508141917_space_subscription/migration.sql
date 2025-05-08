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
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tier" "SubscriptionTier" NOT NULL,
    "spaceId" UUID NOT NULL,
    "decentStatus" "DecentTxStatus" NOT NULL,
    "decentError" JSONB,
    "decentTxHash" TEXT,
    "sourceChainId" INTEGER,
    "txHash" TEXT,
    "chainId" INTEGER,
    "decentPayload" JSONB NOT NULL,
    "cancelledAt" TIMESTAMP(3),

    CONSTRAINT "SpaceSubscriptionPayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpaceSubscriptionReceipt" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "paymentId" UUID NOT NULL,
    "deducedAmount" TEXT NOT NULL,

    CONSTRAINT "SpaceSubscriptionReceipt_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionPayment" ADD CONSTRAINT "SpaceSubscriptionPayment_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionReceipt" ADD CONSTRAINT "SpaceSubscriptionReceipt_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "SpaceSubscriptionPayment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
