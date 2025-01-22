/*
  Warnings:

  - A unique constraint covering the columns `[txHash,txLogIndex,builderNftId,tokensPurchased,senderWalletAddress,walletAddress]` on the table `NFTPurchaseEvent` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "NFTPurchaseEvent" ADD COLUMN     "senderWalletAddress" TEXT,
ADD COLUMN     "txLogIndex" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "NFTPurchaseEvent_txHash_txLogIndex_builderNftId_tokensPurch_key" ON "NFTPurchaseEvent"("txHash", "txLogIndex", "builderNftId", "tokensPurchased", "senderWalletAddress", "walletAddress");

-- AddForeignKey
ALTER TABLE "NFTPurchaseEvent" ADD CONSTRAINT "NFTPurchaseEvent_senderWalletAddress_fkey" FOREIGN KEY ("senderWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
