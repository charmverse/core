-- CreateTable
CREATE TABLE "ScoutProjectContractTransaction" (
    "contractId" UUID NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "txData" JSONB NOT NULL,
    "blockNumber" INTEGER NOT NULL,
    "gasUsed" INTEGER NOT NULL,

    CONSTRAINT "ScoutProjectContractTransaction_pkey" PRIMARY KEY ("txHash")
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_txHash_idx" ON "ScoutProjectContractTransaction"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_blockNumber_idx" ON "ScoutProjectContractTransaction"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransaction_contractId_txHash_key" ON "ScoutProjectContractTransaction"("contractId", "txHash");

-- AddForeignKey
ALTER TABLE "ScoutProjectContractTransaction" ADD CONSTRAINT "ScoutProjectContractTransaction_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
