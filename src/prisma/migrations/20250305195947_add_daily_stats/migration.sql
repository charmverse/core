-- CreateEnum
CREATE TYPE "ChainType" AS ENUM ('evm', 'solana');

-- AlterTable
ALTER TABLE "ScoutProjectWallet" ADD COLUMN     "chainType" "ChainType",
ALTER COLUMN "chainId" DROP NOT NULL;

-- CreateTable
CREATE TABLE "ScoutProjectWalletDailyStats" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "walletId" UUID NOT NULL,
    "day" TIMESTAMP(3) NOT NULL,
    "accounts" INTEGER NOT NULL,
    "transactions" INTEGER NOT NULL,
    "gasFees" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutProjectWalletDailyStats_walletId_idx" ON "ScoutProjectWalletDailyStats"("walletId");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletDailyStats_day_idx" ON "ScoutProjectWalletDailyStats"("day");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectWalletDailyStats_walletId_day_key" ON "ScoutProjectWalletDailyStats"("walletId", "day");

-- AddForeignKey
ALTER TABLE "ScoutProjectWalletDailyStats" ADD CONSTRAINT "ScoutProjectWalletDailyStats_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "ScoutProjectWallet"("id") ON DELETE CASCADE ON UPDATE CASCADE;
