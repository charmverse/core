-- AlterTable
ALTER TABLE "ScoutProject" ALTER COLUMN "avatar" SET DEFAULT '',
ALTER COLUMN "description" SET DEFAULT '',
ALTER COLUMN "website" SET DEFAULT '',
ALTER COLUMN "github" SET DEFAULT '',
ALTER COLUMN "path" SET DEFAULT '';

-- AlterTable
ALTER TABLE "ScoutProjectContract" ALTER COLUMN "blockNumber" SET DATA TYPE BIGINT;

-- CreateTable
CREATE TABLE "ScoutProjectContractTransactioData" (
    "contractId" UUID NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "txData" JSONB NOT NULL,
    "blockNumber" BIGINT NOT NULL,
    "gasUsed" INTEGER NOT NULL,

    CONSTRAINT "ScoutProjectContractTransactioData_pkey" PRIMARY KEY ("txHash")
);

-- CreateTable
CREATE TABLE "ScoutProjectContractLogEvent" (
    "contractId" UUID NOT NULL,
    "from" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "logIndex" INTEGER NOT NULL,
    "blockNumber" BIGINT NOT NULL,

    CONSTRAINT "ScoutProjectContractLogEvent_pkey" PRIMARY KEY ("txHash")
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransactioData_txHash_idx" ON "ScoutProjectContractTransactioData"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransactioData_blockNumber_idx" ON "ScoutProjectContractTransactioData"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransactioData_contractId_txHash_key" ON "ScoutProjectContractTransactioData"("contractId", "txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractLogEvent_txHash_idx" ON "ScoutProjectContractLogEvent"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractLogEvent_blockNumber_idx" ON "ScoutProjectContractLogEvent"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractLogEvent_contractId_txHash_logIndex_key" ON "ScoutProjectContractLogEvent"("contractId", "txHash", "logIndex");

-- CreateIndex
CREATE INDEX "ScoutProject_path_idx" ON "ScoutProject"("path");

-- AddForeignKey
ALTER TABLE "ScoutProjectContractTransactioData" ADD CONSTRAINT "ScoutProjectContractTransactioData_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectContractLogEvent" ADD CONSTRAINT "ScoutProjectContractLogEvent_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
