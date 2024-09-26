/*
  Warnings:

  - Added the required column `season` to the `GemsPayoutEvent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `season` to the `UserWeeklyStats` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "BuilderEvent" ALTER COLUMN "season" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "BuilderNft" ALTER COLUMN "season" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "GemsPayoutEvent" ADD COLUMN     "season" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "UserSeasonStats" ALTER COLUMN "season" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "UserWeeklyStats" ADD COLUMN     "season" TEXT NOT NULL;
