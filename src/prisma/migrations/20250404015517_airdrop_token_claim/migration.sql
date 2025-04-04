-- CreateTable
CREATE TABLE "AirdropTokenClaim" (
    "address" TEXT NOT NULL,
    "tokenAddress" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "season" TEXT NOT NULL,
    "donationAmount" TEXT NOT NULL,
    "claimedAt" TIMESTAMP(3)
);

-- CreateIndex
CREATE INDEX "AirdropTokenClaim_address_idx" ON "AirdropTokenClaim"("address");

-- CreateIndex
CREATE UNIQUE INDEX "AirdropTokenClaim_season_address_key" ON "AirdropTokenClaim"("season", "address");

-- AddForeignKey
ALTER TABLE "AirdropTokenClaim" ADD CONSTRAINT "AirdropTokenClaim_address_fkey" FOREIGN KEY ("address") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
