/*
  Warnings:

  - Made the column `estimatedPayout` on table `BuilderNft` required. This step will fail if there are existing NULL values in that column.
  - Made the column `level` on table `UserSeasonStats` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "BuilderNft" ALTER COLUMN "estimatedPayout" SET NOT NULL,
ALTER COLUMN "estimatedPayout" SET DEFAULT 0;

-- AlterTable
ALTER TABLE "UserSeasonStats" ALTER COLUMN "level" SET NOT NULL,
ALTER COLUMN "level" SET DEFAULT 0;
