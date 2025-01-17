-- AlterTable
ALTER TABLE "NFTPurchaseEvent" ADD COLUMN     "senderWalletAddress" TEXT,
ALTER COLUMN "scoutId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "NFTPurchaseEvent" ADD CONSTRAINT "NFTPurchaseEvent_senderWalletAddress_fkey" FOREIGN KEY ("senderWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
