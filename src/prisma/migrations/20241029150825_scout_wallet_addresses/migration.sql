-- CreateTable
CREATE TABLE "ScoutWallet" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "address" TEXT NOT NULL,
    "scoutId" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "ScoutWallet_address_key" ON "ScoutWallet"("address");

-- CreateIndex
CREATE INDEX "ScoutWallet_address_idx" ON "ScoutWallet"("address");

-- CreateIndex
CREATE INDEX "ScoutWallet_scoutId_idx" ON "ScoutWallet"("scoutId");

-- AddForeignKey
ALTER TABLE "ScoutWallet" ADD CONSTRAINT "ScoutWallet_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
