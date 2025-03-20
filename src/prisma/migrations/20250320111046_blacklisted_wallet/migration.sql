-- AlterTable
ALTER TABLE "ScoutWallet" ADD COLUMN     "blacklisted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "blacklistedCheckedAt" TIMESTAMP(3);
