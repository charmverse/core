/*
  Warnings:

  - A unique constraint covering the columns `[contractAddress,chainId,eventName]` on the table `BlockchainLogsContract` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "BlockchainLogsContract_contractAddress_chainId_key";

-- AlterTable
ALTER TABLE "BlockchainLogsContract" ADD COLUMN     "eventName" TEXT;

-- CreateIndex
CREATE INDEX "BlockchainLogsContract_eventName_idx" ON "BlockchainLogsContract"("eventName");

-- CreateIndex
CREATE UNIQUE INDEX "BlockchainLogsContract_contractAddress_chainId_eventName_key" ON "BlockchainLogsContract"("contractAddress", "chainId", "eventName");
