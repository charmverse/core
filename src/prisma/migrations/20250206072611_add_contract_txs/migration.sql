-- AlterTable
ALTER TABLE "ScoutProject" ALTER COLUMN "avatar" SET DEFAULT '',
ALTER COLUMN "description" SET DEFAULT '',
ALTER COLUMN "website" SET DEFAULT '',
ALTER COLUMN "github" SET DEFAULT '',
ALTER COLUMN "path" SET DEFAULT '';

-- AlterTable
ALTER TABLE "ScoutProjectContract" ALTER COLUMN "blockNumber" SET DATA TYPE BIGINT;

-- CreateTable
CREATE TABLE "ScoutProjectContractTransaction" (
    "contractId" UUID NOT NULL,
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
CREATE TABLE "ScoutProjectContractPollEvent" (
    "contractId" UUID NOT NULL,
    "fromBlockNumber" BIGINT NOT NULL,
    "toBlockNumber" BIGINT NOT NULL,
    "processedAt" TIMESTAMP(3) NOT NULL,
    "processTime" INTEGER NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_txHash_idx" ON "ScoutProjectContractTransaction"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_blockNumber_idx" ON "ScoutProjectContractTransaction"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransaction_contractId_txHash_key" ON "ScoutProjectContractTransaction"("contractId", "txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractPollEvent_contractId_idx" ON "ScoutProjectContractPollEvent"("contractId");

-- CreateIndex
CREATE INDEX "ScoutProjectContractPollEvent_toBlockNumber_idx" ON "ScoutProjectContractPollEvent"("toBlockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractPollEvent_contractId_toBlockNumber_key" ON "ScoutProjectContractPollEvent"("contractId", "toBlockNumber");

-- CreateIndex
CREATE INDEX "ScoutProject_path_idx" ON "ScoutProject"("path");

-- AddForeignKey
ALTER TABLE "ScoutProjectContractTransaction" ADD CONSTRAINT "ScoutProjectContractTransaction_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
