-- AlterTable
ALTER TABLE "ScoutWallet" ADD COLUMN     "primary" BOOLEAN NOT NULL DEFAULT false;

-- CreateIndex
CREATE INDEX "ScoutWallet_primary_scoutId_idx" ON "ScoutWallet"("primary", "scoutId");
