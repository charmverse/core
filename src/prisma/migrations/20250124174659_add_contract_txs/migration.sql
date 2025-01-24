/*
  Warnings:

  - A unique constraint covering the columns `[contractId,txHash,logIndex]` on the table `ScoutProjectContractTransactioData` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[contractId,txHash,logIndex]` on the table `ScoutProjectContractTransaction` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `logIndex` to the `ScoutProjectContractTransactioData` table without a default value. This is not possible if the table is not empty.
  - Added the required column `logIndex` to the `ScoutProjectContractTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "ScoutProjectContractTransactioData_contractId_txHash_key";

-- DropIndex
DROP INDEX "ScoutProjectContractTransaction_contractId_txHash_key";

-- AlterTable
ALTER TABLE "ScoutProjectContractTransactioData" ADD COLUMN     "logIndex" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "ScoutProjectContractTransaction" ADD COLUMN     "logIndex" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransactioData_contractId_txHash_logInd_key" ON "ScoutProjectContractTransactioData"("contractId", "txHash", "logIndex");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransaction_contractId_txHash_logIndex_key" ON "ScoutProjectContractTransaction"("contractId", "txHash", "logIndex");
