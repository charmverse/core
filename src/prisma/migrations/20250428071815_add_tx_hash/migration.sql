/*
  Warnings:

  - A unique constraint covering the columns `[txHash,txChainId]` on the table `ScoutMatchup` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[decentTxHash,decentTxChainId]` on the table `ScoutMatchup` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "ScoutMatchup" ADD COLUMN     "decentTxChainId" INTEGER,
ADD COLUMN     "decentTxHash" TEXT,
ADD COLUMN     "txChainId" INTEGER,
ADD COLUMN     "txHash" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_txHash_txChainId_key" ON "ScoutMatchup"("txHash", "txChainId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_decentTxHash_decentTxChainId_key" ON "ScoutMatchup"("decentTxHash", "decentTxChainId");
