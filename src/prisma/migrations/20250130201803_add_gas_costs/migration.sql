/*
  Warnings:

  - Added the required column `gasCost` to the `ScoutProjectContractTransaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gasPrice` to the `ScoutProjectContractTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ScoutProjectContractTransaction" ADD COLUMN     "gasCost" BIGINT NOT NULL,
ADD COLUMN     "gasPrice" BIGINT NOT NULL;

-- CreateTable
CREATE TABLE "ScoutProjectContractPollEvent" (
    "contractId" UUID NOT NULL,
    "fromBlockNumber" BIGINT NOT NULL,
    "toBlockNumber" BIGINT NOT NULL,
    "processedAt" TIMESTAMP(3) NOT NULL,
    "processTime" INTEGER NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutProjectContractPollEvent_contractId_idx" ON "ScoutProjectContractPollEvent"("contractId");

-- CreateIndex
CREATE INDEX "ScoutProjectContractPollEvent_toBlockNumber_idx" ON "ScoutProjectContractPollEvent"("toBlockNumber");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContractPollEvent_contractId_toBlockNumber_key" ON "ScoutProjectContractPollEvent"("contractId", "toBlockNumber");
