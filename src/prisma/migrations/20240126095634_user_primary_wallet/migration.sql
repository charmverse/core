-- AlterTable
ALTER TABLE "User" ADD COLUMN     "primaryWalletId" UUID;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_primaryWalletId_fkey" FOREIGN KEY ("primaryWalletId") REFERENCES "UserWallet"("id") ON DELETE SET NULL ON UPDATE CASCADE;
