-- AlterTable
ALTER TABLE "IssuedCredential" ADD COLUMN     "hidden" BOOLEAN DEFAULT false;

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "credentialsWallet" TEXT,
ADD COLUMN     "useOnchainCredentials" BOOLEAN DEFAULT false;
