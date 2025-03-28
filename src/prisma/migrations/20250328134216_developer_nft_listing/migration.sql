-- CreateTable
CREATE TABLE "DeveloperNftListing" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "builderNftId" UUID NOT NULL,
    "sellerWallet" TEXT NOT NULL,
    "buyerWallet" TEXT,
    "price" BIGINT,
    "priceDevToken" TEXT,
    "amount" INTEGER NOT NULL,
    "signature" TEXT NOT NULL,
    "hash" TEXT,
    "completedAt" TIMESTAMP(3),
    "order" JSONB,

    CONSTRAINT "DeveloperNftListing_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "DeveloperNftListing_builderNftId_idx" ON "DeveloperNftListing"("builderNftId");

-- CreateIndex
CREATE INDEX "DeveloperNftListing_sellerWallet_idx" ON "DeveloperNftListing"("sellerWallet");

-- CreateIndex
CREATE INDEX "DeveloperNftListing_completedAt_idx" ON "DeveloperNftListing"("completedAt");

-- CreateIndex
CREATE INDEX "DeveloperNftListing_buyerWallet_idx" ON "DeveloperNftListing"("buyerWallet");

-- AddForeignKey
ALTER TABLE "DeveloperNftListing" ADD CONSTRAINT "DeveloperNftListing_builderNftId_fkey" FOREIGN KEY ("builderNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeveloperNftListing" ADD CONSTRAINT "DeveloperNftListing_sellerWallet_fkey" FOREIGN KEY ("sellerWallet") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeveloperNftListing" ADD CONSTRAINT "DeveloperNftListing_buyerWallet_fkey" FOREIGN KEY ("buyerWallet") REFERENCES "ScoutWallet"("address") ON DELETE SET NULL ON UPDATE CASCADE;
