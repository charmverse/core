-- DropForeignKey
ALTER TABLE "ScoutGameActivity" DROP CONSTRAINT "ScoutGameActivity_builderStrikeId_fkey";

-- DropForeignKey
ALTER TABLE "ScoutGameActivity" DROP CONSTRAINT "ScoutGameActivity_gemsReceiptId_fkey";

-- DropForeignKey
ALTER TABLE "ScoutGameActivity" DROP CONSTRAINT "ScoutGameActivity_nftPurchaseEventId_fkey";

-- DropForeignKey
ALTER TABLE "ScoutGameActivity" DROP CONSTRAINT "ScoutGameActivity_pointsReceiptId_fkey";

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_gemsReceiptId_fkey" FOREIGN KEY ("gemsReceiptId") REFERENCES "GemsReceipt"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_pointsReceiptId_fkey" FOREIGN KEY ("pointsReceiptId") REFERENCES "PointsReceipt"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_nftPurchaseEventId_fkey" FOREIGN KEY ("nftPurchaseEventId") REFERENCES "NFTPurchaseEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_builderStrikeId_fkey" FOREIGN KEY ("builderStrikeId") REFERENCES "BuilderStrike"("id") ON DELETE CASCADE ON UPDATE CASCADE;
