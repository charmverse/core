/*
  Warnings:

  - A unique constraint covering the columns `[builderId,season,nftType]` on the table `BuilderNft` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "BuilderNftType" AS ENUM ('default', 'season_1_starter_pack');

-- DropIndex
DROP INDEX "BuilderNft_builderId_season_key";

-- AlterTable
ALTER TABLE "BuilderNft" ADD COLUMN     "nftType" "BuilderNftType" NOT NULL DEFAULT 'default';

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_builderId_season_nftType_key" ON "BuilderNft"("builderId", "season", "nftType");
