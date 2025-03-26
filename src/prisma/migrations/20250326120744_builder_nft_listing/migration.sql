-- CreateTable
CREATE TABLE "BuilderNftListing" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "builderNftId" UUID NOT NULL,
    "sellerWallet" TEXT NOT NULL,
    "price" BIGINT NOT NULL,
    "amount" INTEGER NOT NULL,
    "signature" TEXT NOT NULL,
    "completedAt" TIMESTAMP(3),
    "cancelledAt" TIMESTAMP(3),
    "buyerWallet" TEXT,
    "scoutWalletAddress" TEXT,
    "orderHash" TEXT,
    "order" JSONB,

    CONSTRAINT "BuilderNftListing_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "BuilderNftListing_builderNftId_idx" ON "BuilderNftListing"("builderNftId");

-- CreateIndex
CREATE INDEX "BuilderNftListing_sellerWallet_idx" ON "BuilderNftListing"("sellerWallet");

-- CreateIndex
CREATE INDEX "BuilderNftListing_completedAt_idx" ON "BuilderNftListing"("completedAt");

-- CreateIndex
CREATE INDEX "BuilderNftListing_cancelledAt_idx" ON "BuilderNftListing"("cancelledAt");

-- CreateIndex
CREATE INDEX "BuilderNftListing_buyerWallet_idx" ON "BuilderNftListing"("buyerWallet");

-- AddForeignKey
ALTER TABLE "BuilderNftListing" ADD CONSTRAINT "BuilderNftListing_builderNftId_fkey" FOREIGN KEY ("builderNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderNftListing" ADD CONSTRAINT "BuilderNftListing_sellerWallet_fkey" FOREIGN KEY ("sellerWallet") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderNftListing" ADD CONSTRAINT "BuilderNftListing_buyerWallet_fkey" FOREIGN KEY ("buyerWallet") REFERENCES "ScoutWallet"("address") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderNftListing" ADD CONSTRAINT "BuilderNftListing_scoutWalletAddress_fkey" FOREIGN KEY ("scoutWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE SET NULL ON UPDATE CASCADE;
