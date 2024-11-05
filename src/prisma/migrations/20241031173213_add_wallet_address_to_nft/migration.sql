-- AlterTable
ALTER TABLE "NFTPurchaseEvent" ADD COLUMN     "walletAddress" TEXT;

-- AddForeignKey
ALTER TABLE "NFTPurchaseEvent" ADD CONSTRAINT "NFTPurchaseEvent_walletAddress_fkey" FOREIGN KEY ("walletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
