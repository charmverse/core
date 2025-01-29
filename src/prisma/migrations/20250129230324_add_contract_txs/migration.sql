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
    "gasUsed" BIGINT NOT NULL
);

-- CreateTable
CREATE TABLE "ScoutProjectContractLog" (
    "contractId" UUID NOT NULL,
    "from" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "logIndex" INTEGER NOT NULL,
    "blockNumber" BIGINT NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_txHash_idx" ON "ScoutProjectContractTransaction"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_blockNumber_idx" ON "ScoutProjectContractTransaction"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransaction_contractId_txHash_key" ON "ScoutProjectContractTransaction"("contractId", "txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractLog_txHash_idx" ON "ScoutProjectContractLog"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractLog_blockNumber_idx" ON "ScoutProjectContractLog"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractLog_contractId_txHash_logIndex_key" ON "ScoutProjectContractLog"("contractId", "txHash", "logIndex");

-- CreateIndex
CREATE INDEX "ScoutProject_path_idx" ON "ScoutProject"("path");

-- AddForeignKey
ALTER TABLE "ScoutProjectContractTransaction" ADD CONSTRAINT "ScoutProjectContractTransaction_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectContractLog" ADD CONSTRAINT "ScoutProjectContractLog_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
