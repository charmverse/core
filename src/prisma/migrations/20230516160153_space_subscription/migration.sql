-- CreateEnum
CREATE TYPE "SubscriptionPeriod" AS ENUM ('monthly', 'annual');

-- CreateTable
CREATE TABLE "SpaceSubscription" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "spaceId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL,
    "period" "SubscriptionPeriod" NOT NULL,
    "customerId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "subscriptionId" TEXT NOT NULL,
    "usage" INTEGER NOT NULL,

    CONSTRAINT "SpaceSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "SpaceSubscription_spaceId_idx" ON "SpaceSubscription"("spaceId");

-- AddForeignKey
ALTER TABLE "SpaceSubscription" ADD CONSTRAINT "SpaceSubscription_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
