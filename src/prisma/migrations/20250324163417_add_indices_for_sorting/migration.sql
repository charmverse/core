/*
  Warnings:

  - A unique constraint covering the columns `[currentPrice,createdAt,season,nftType]` on the table `BuilderNft` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[estimatedPayout,createdAt,season,nftType]` on the table `BuilderNft` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,level,season]` on the table `UserSeasonStats` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,gemsCollected,season]` on the table `UserWeeklyStats` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "UserSeasonStats" ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "UserSeasonStats_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "UserWeeklyStats" ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "UserWeeklyStats_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_currentPrice_createdAt_season_nftType_key" ON "BuilderNft"("currentPrice", "createdAt", "season", "nftType");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_estimatedPayout_createdAt_season_nftType_key" ON "BuilderNft"("estimatedPayout", "createdAt", "season", "nftType");

-- CreateIndex
CREATE UNIQUE INDEX "UserSeasonStats_id_level_season_key" ON "UserSeasonStats"("id", "level", "season");

-- CreateIndex
CREATE UNIQUE INDEX "UserWeeklyStats_id_gemsCollected_season_key" ON "UserWeeklyStats"("id", "gemsCollected", "season");
