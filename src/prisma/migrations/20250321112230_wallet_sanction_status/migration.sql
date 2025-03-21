-- AlterTable
ALTER TABLE "ScoutWallet" ADD COLUMN     "isSanctioned" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "lastSanctionCheckedAt" TIMESTAMP(3);
