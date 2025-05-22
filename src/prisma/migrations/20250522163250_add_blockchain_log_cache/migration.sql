-- CreateTable
CREATE TABLE "BlockchainLogsContract" (
    "id" UUID NOT NULL,
    "contractAddress" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "firstBlockNumber" BIGINT NOT NULL,
    "firstBlockDate" TIMESTAMP(3) NOT NULL,
    "lastBlockNumber" BIGINT NOT NULL,
    "lastBlockDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BlockchainLogsContract_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BlockchainLog" (
    "logIndex" INTEGER NOT NULL,
    "logData" JSONB NOT NULL,
    "blockNumber" BIGINT NOT NULL,
    "blockDate" TIMESTAMP(3) NOT NULL,
    "eventName" TEXT NOT NULL,
    "contractId" UUID NOT NULL
);

-- CreateIndex
CREATE INDEX "BlockchainLogsContract_contractAddress_idx" ON "BlockchainLogsContract"("contractAddress");

-- CreateIndex
CREATE INDEX "BlockchainLogsContract_chainId_idx" ON "BlockchainLogsContract"("chainId");

-- CreateIndex
CREATE UNIQUE INDEX "BlockchainLogsContract_contractAddress_chainId_key" ON "BlockchainLogsContract"("contractAddress", "chainId");

-- CreateIndex
CREATE INDEX "BlockchainLog_contractId_idx" ON "BlockchainLog"("contractId");

-- CreateIndex
CREATE INDEX "BlockchainLog_eventName_idx" ON "BlockchainLog"("eventName");

-- CreateIndex
CREATE UNIQUE INDEX "BlockchainLog_contractId_blockNumber_logIndex_key" ON "BlockchainLog"("contractId", "blockNumber", "logIndex");

-- AddForeignKey
ALTER TABLE "BlockchainLog" ADD CONSTRAINT "BlockchainLog_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "BlockchainLogsContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
