-- CreateTable
CREATE TABLE "SpaceSubscription" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "spaceId" UUID NOT NULL,
    "balance" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "cancelledAt" TIMESTAMP(3),

    CONSTRAINT "SpaceSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpaceSubscriptionReceipt" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "spaceSubscriptionId" UUID NOT NULL,
    "deducedAmount" TEXT NOT NULL,

    CONSTRAINT "SpaceSubscriptionReceipt_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceSubscription" ADD CONSTRAINT "SpaceSubscription_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionReceipt" ADD CONSTRAINT "SpaceSubscriptionReceipt_spaceSubscriptionId_fkey" FOREIGN KEY ("spaceSubscriptionId") REFERENCES "SpaceSubscription"("id") ON DELETE CASCADE ON UPDATE CASCADE;
