-- AlterTable
ALTER TABLE "NFTPurchaseEvent" ADD COLUMN     "senderWalletAddress" TEXT;

-- AddForeignKey
ALTER TABLE "NFTPurchaseEvent" ADD CONSTRAINT "NFTPurchaseEvent_senderWalletAddress_fkey" FOREIGN KEY ("senderWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
