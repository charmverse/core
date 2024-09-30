/*
  Warnings:

  - The values [mint,gems_from_pr,gems,strike,builder_registered] on the enum `ScoutGameActivityType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `pointsDirection` on the `ScoutGameActivity` table. All the data in the column will be lost.
  - You are about to drop the column `registeredBuilderNftId` on the `ScoutGameActivity` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userId,pointsReceiptId]` on the table `ScoutGameActivity` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,nftPurchaseEventId]` on the table `ScoutGameActivity` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,builderStrikeId]` on the table `ScoutGameActivity` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,gemsReceiptId]` on the table `ScoutGameActivity` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ScoutGameActivityType_new" AS ENUM ('gems_first_pr', 'gems_third_pr_in_streak', 'gems_regular_pr', 'nft_purchase', 'builder_strike', 'builder_suspended', 'points');
ALTER TABLE "ScoutGameActivity" ALTER COLUMN "type" TYPE "ScoutGameActivityType_new" USING ("type"::text::"ScoutGameActivityType_new");
ALTER TYPE "ScoutGameActivityType" RENAME TO "ScoutGameActivityType_old";
ALTER TYPE "ScoutGameActivityType_new" RENAME TO "ScoutGameActivityType";
DROP TYPE "ScoutGameActivityType_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "ScoutGameActivity" DROP CONSTRAINT "ScoutGameActivity_registeredBuilderNftId_fkey";

-- DropIndex
DROP INDEX "ScoutGameActivity_gemsPayoutEventId_idx";

-- DropIndex
DROP INDEX "ScoutGameActivity_registeredBuilderNftId_idx";

-- DropIndex
DROP INDEX "ScoutGameActivity_userId_pointsDirection_builderStrikeId_key";

-- DropIndex
DROP INDEX "ScoutGameActivity_userId_pointsDirection_gemsPayoutEventId_key";

-- DropIndex
DROP INDEX "ScoutGameActivity_userId_pointsDirection_gemsReceiptId_key";

-- DropIndex
DROP INDEX "ScoutGameActivity_userId_pointsDirection_nftPurchaseEventId_key";

-- DropIndex
DROP INDEX "ScoutGameActivity_userId_pointsDirection_pointsReceiptId_key";

-- DropIndex
DROP INDEX "ScoutGameActivity_userId_pointsDirection_registeredBuilderN_key";

-- AlterTable
ALTER TABLE "ScoutGameActivity" DROP COLUMN "pointsDirection",
DROP COLUMN "registeredBuilderNftId",
ADD COLUMN     "builderNftId" UUID;

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_pointsReceiptId_key" ON "ScoutGameActivity"("userId", "pointsReceiptId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_nftPurchaseEventId_key" ON "ScoutGameActivity"("userId", "nftPurchaseEventId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_builderStrikeId_key" ON "ScoutGameActivity"("userId", "builderStrikeId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutGameActivity_userId_gemsReceiptId_key" ON "ScoutGameActivity"("userId", "gemsReceiptId");

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_builderNftId_fkey" FOREIGN KEY ("builderNftId") REFERENCES "BuilderNft"("id") ON DELETE SET NULL ON UPDATE CASCADE;
