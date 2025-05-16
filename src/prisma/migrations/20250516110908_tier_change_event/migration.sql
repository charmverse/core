-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "subscriptionTierCancelledAt" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "SpaceSubscriptionTierChangeEvent" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "spaceId" UUID NOT NULL,
    "previousTier" "SpaceSubscriptionTier" NOT NULL,
    "newTier" "SpaceSubscriptionTier" NOT NULL,

    CONSTRAINT "SpaceSubscriptionTierChangeEvent_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionTierChangeEvent" ADD CONSTRAINT "SpaceSubscriptionTierChangeEvent_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
