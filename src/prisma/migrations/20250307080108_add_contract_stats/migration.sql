/*
  Warnings:

  - Made the column `chainType` on table `ScoutProjectWallet` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `week` to the `ScoutProjectWalletDailyStats` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ScoutProjectWallet" ALTER COLUMN "chainType" SET NOT NULL;

-- AlterTable
ALTER TABLE "ScoutProjectWalletDailyStats" ADD COLUMN     "week" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "ScoutProjectContractDailyStats" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "contractId" UUID NOT NULL,
    "day" TIMESTAMP(3) NOT NULL,
    "accounts" INTEGER NOT NULL,
    "transactions" INTEGER NOT NULL,
    "gasFees" TEXT NOT NULL,
    "week" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractDailyStats_contractId_idx" ON "ScoutProjectContractDailyStats"("contractId");

-- CreateIndex
CREATE INDEX "ScoutProjectContractDailyStats_day_idx" ON "ScoutProjectContractDailyStats"("day");

-- CreateIndex
CREATE INDEX "ScoutProjectContractDailyStats_week_idx" ON "ScoutProjectContractDailyStats"("week");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractDailyStats_contractId_day_key" ON "ScoutProjectContractDailyStats"("contractId", "day");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletDailyStats_week_idx" ON "ScoutProjectWalletDailyStats"("week");

-- AddForeignKey
ALTER TABLE "ScoutProjectContractDailyStats" ADD CONSTRAINT "ScoutProjectContractDailyStats_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
