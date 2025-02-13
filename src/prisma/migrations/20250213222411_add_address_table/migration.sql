-- CreateTable
CREATE TABLE "ScoutProjectAddress" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "address" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "verifiedAt" TIMESTAMP(3),
    "verifiedBy" UUID,

    CONSTRAINT "ScoutProjectAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutProjectAddressTransaction" (
    "addressId" UUID NOT NULL,
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

-- CreateIndex
CREATE INDEX "ScoutProjectAddress_projectId_idx" ON "ScoutProjectAddress"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectAddress_address_idx" ON "ScoutProjectAddress"("address");

-- CreateIndex
CREATE INDEX "ScoutProjectAddress_deletedAt_idx" ON "ScoutProjectAddress"("deletedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectAddress_address_chainId_key" ON "ScoutProjectAddress"("address", "chainId");

-- CreateIndex
CREATE INDEX "ScoutProjectAddressTransaction_txHash_idx" ON "ScoutProjectAddressTransaction"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectAddressTransaction_blockNumber_idx" ON "ScoutProjectAddressTransaction"("blockNumber");

-- CreateIndex
CREATE INDEX "ScoutProjectAddressTransaction_createdAt_idx" ON "ScoutProjectAddressTransaction"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectAddressTransaction_addressId_txHash_key" ON "ScoutProjectAddressTransaction"("addressId", "txHash");

-- AddForeignKey
ALTER TABLE "ScoutProjectAddress" ADD CONSTRAINT "ScoutProjectAddress_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectAddressTransaction" ADD CONSTRAINT "ScoutProjectAddressTransaction_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "ScoutProjectAddress"("id") ON DELETE CASCADE ON UPDATE CASCADE;
