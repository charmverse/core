/*
  Warnings:

  - A unique constraint covering the columns `[path]` on the table `ScoutProject` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "ScoutProject" ADD COLUMN     "path" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "avatar" SET DEFAULT '',
ALTER COLUMN "description" SET DEFAULT '',
ALTER COLUMN "website" SET DEFAULT '',
ALTER COLUMN "github" SET DEFAULT '';

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

    CONSTRAINT "ScoutProjectContractTransactioData_pkey" PRIMARY KEY ("txHash")
);

-- CreateTable
CREATE TABLE "ScoutProjectContractTransaction" (
    "contractId" UUID NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "txHash" TEXT NOT NULL,
    "blockNumber" BIGINT NOT NULL,
    "gasUsed" INTEGER NOT NULL,

    CONSTRAINT "ScoutProjectContractTransaction_pkey" PRIMARY KEY ("txHash")
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransactioData_txHash_idx" ON "ScoutProjectContractTransactioData"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransactioData_blockNumber_idx" ON "ScoutProjectContractTransactioData"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransactioData_contractId_txHash_key" ON "ScoutProjectContractTransactioData"("contractId", "txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_txHash_idx" ON "ScoutProjectContractTransaction"("txHash");

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_blockNumber_idx" ON "ScoutProjectContractTransaction"("blockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractTransaction_contractId_txHash_key" ON "ScoutProjectContractTransaction"("contractId", "txHash");

-- CreateIndex
CREATE INDEX "ScoutProject_path_idx" ON "ScoutProject"("path");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProject_path_key" ON "ScoutProject"("path");

-- AddForeignKey
ALTER TABLE "ScoutProjectContractTransactioData" ADD CONSTRAINT "ScoutProjectContractTransactioData_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectContractTransaction" ADD CONSTRAINT "ScoutProjectContractTransaction_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "ScoutProjectContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
