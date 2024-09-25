-- CreateEnum
CREATE TYPE "ScoutGameActivityType" AS ENUM ('mint', 'gems', 'points', 'strike', 'builder_nft');

-- CreateEnum
CREATE TYPE "PointsDirection" AS ENUM ('in', 'out');

-- CreateTable
CREATE TABLE "ScoutGameActivity" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" "ScoutGameActivityType" NOT NULL,
    "pointsDirection" "PointsDirection" NOT NULL,
    "amount" INTEGER NOT NULL,
    "userId" UUID NOT NULL,
    "gemsPayoutEventId" UUID,
    "pointsReceiptId" UUID,
    "nftPurchaseEventId" UUID,
    "builderStrikeId" UUID,
    "notificationSentAt" TIMESTAMP(3),
    "onchainTxHash" TEXT,
    "onchainChainId" INTEGER,

    CONSTRAINT "ScoutGameActivity_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_gemsPayoutEventId_key" ON "ScoutGameActivity"("gemsPayoutEventId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_pointsReceiptId_key" ON "ScoutGameActivity"("pointsReceiptId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_nftPurchaseEventId_key" ON "ScoutGameActivity"("nftPurchaseEventId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_userId_idx" ON "ScoutGameActivity"("userId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_type_idx" ON "ScoutGameActivity"("type");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_userId_type_idx" ON "ScoutGameActivity"("userId", "type");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_gemsPayoutEventId_idx" ON "ScoutGameActivity"("gemsPayoutEventId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_pointsReceiptId_idx" ON "ScoutGameActivity"("pointsReceiptId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_nftPurchaseEventId_idx" ON "ScoutGameActivity"("nftPurchaseEventId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_builderStrikeId_idx" ON "ScoutGameActivity"("builderStrikeId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_onchainChainId_idx" ON "ScoutGameActivity"("onchainChainId");

-- CreateIndex
CREATE INDEX "ScoutGameActivity_notificationSentAt_idx" ON "ScoutGameActivity"("notificationSentAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_onchainTxHash_onchainChainId_key" ON "ScoutGameActivity"("onchainTxHash", "onchainChainId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_pointsDirection_gemsPayoutEventId_key" ON "ScoutGameActivity"("userId", "pointsDirection", "gemsPayoutEventId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_pointsDirection_pointsReceiptId_key" ON "ScoutGameActivity"("userId", "pointsDirection", "pointsReceiptId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_pointsDirection_nftPurchaseEventId_key" ON "ScoutGameActivity"("userId", "pointsDirection", "nftPurchaseEventId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_pointsDirection_builderStrikeId_key" ON "ScoutGameActivity"("userId", "pointsDirection", "builderStrikeId");

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_gemsPayoutEventId_fkey" FOREIGN KEY ("gemsPayoutEventId") REFERENCES "GemsPayoutEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_pointsReceiptId_fkey" FOREIGN KEY ("pointsReceiptId") REFERENCES "PointsReceipt"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_nftPurchaseEventId_fkey" FOREIGN KEY ("nftPurchaseEventId") REFERENCES "NFTPurchaseEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_builderStrikeId_fkey" FOREIGN KEY ("builderStrikeId") REFERENCES "BuilderStrike"("id") ON DELETE SET NULL ON UPDATE CASCADE;
