/*
  Warnings:

  - A unique constraint covering the columns `[currentPrice,createdAt]` on the table `BuilderNft` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[estimatedPayout,createdAt]` on the table `BuilderNft` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,level]` on the table `UserSeasonStats` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[pointsEarnedAsScout,nftsPurchased,id]` on the table `UserSeasonStats` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,gemsCollected]` on the table `UserWeeklyStats` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "UserSeasonStats" ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "UserSeasonStats_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "UserWeeklyStats" ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "UserWeeklyStats_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_currentPrice_createdAt_key" ON "BuilderNft"("currentPrice", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_estimatedPayout_createdAt_key" ON "BuilderNft"("estimatedPayout", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "UserSeasonStats_id_level_key" ON "UserSeasonStats"("id", "level");

-- CreateIndex
CREATE UNIQUE INDEX "UserSeasonStats_pointsEarnedAsScout_nftsPurchased_id_key" ON "UserSeasonStats"("pointsEarnedAsScout", "nftsPurchased", "id");

-- CreateIndex
CREATE UNIQUE INDEX "UserWeeklyStats_id_gemsCollected_key" ON "UserWeeklyStats"("id", "gemsCollected");
