-- CreateTable
CREATE TABLE "ScoutProjectWallet" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "address" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "verifiedAt" TIMESTAMP(3),
    "verifiedBy" UUID,

    CONSTRAINT "ScoutProjectWallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutProjectWalletTransaction" (
    "walletId" UUID NOT NULL,
    "chainId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "txData" JSONB NOT NULL,
    "blockNumber" BIGINT NOT NULL,
    "gasUsed" BIGINT NOT NULL,
    "gasPrice" BIGINT NOT NULL,
    "gasCost" BIGINT NOT NULL
);

-- CreateTable
CREATE TABLE "ScoutProjectWalletPollEvent" (
    "walletId" UUID NOT NULL,
    "fromBlockNumber" BIGINT NOT NULL,
    "toBlockNumber" BIGINT NOT NULL,
    "processedAt" TIMESTAMP(3) NOT NULL,
    "processTime" INTEGER NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutProjectWallet_projectId_idx" ON "ScoutProjectWallet"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectWallet_address_idx" ON "ScoutProjectWallet"("address");

-- CreateIndex
CREATE INDEX "ScoutProjectWallet_deletedAt_idx" ON "ScoutProjectWallet"("deletedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectWallet_address_chainId_key" ON "ScoutProjectWallet"("address", "chainId");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletTransaction_txHash_idx" ON "ScoutProjectWalletTransaction"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletTransaction_blockNumber_idx" ON "ScoutProjectWalletTransaction"("blockNumber");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletTransaction_createdAt_idx" ON "ScoutProjectWalletTransaction"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectWalletTransaction_walletId_txHash_key" ON "ScoutProjectWalletTransaction"("walletId", "txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletPollEvent_walletId_idx" ON "ScoutProjectWalletPollEvent"("walletId");

-- CreateIndex
CREATE INDEX "ScoutProjectWalletPollEvent_toBlockNumber_idx" ON "ScoutProjectWalletPollEvent"("toBlockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectWalletPollEvent_walletId_toBlockNumber_key" ON "ScoutProjectWalletPollEvent"("walletId", "toBlockNumber");

-- AddForeignKey
ALTER TABLE "ScoutProjectWallet" ADD CONSTRAINT "ScoutProjectWallet_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectWalletTransaction" ADD CONSTRAINT "ScoutProjectWalletTransaction_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "ScoutProjectWallet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectContractPollEvent" ADD CONSTRAINT "ScoutProjectContractPollEvent_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectWalletPollEvent" ADD CONSTRAINT "ScoutProjectWalletPollEvent_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "ScoutProjectWallet"("id") ON DELETE CASCADE ON UPDATE CASCADE;
