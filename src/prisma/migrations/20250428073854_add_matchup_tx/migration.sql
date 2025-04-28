/*
  Warnings:

  - A unique constraint covering the columns `[registrationTxId]` on the table `ScoutMatchup` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[decentRegistrationTxId]` on the table `ScoutMatchup` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "ScoutMatchup" ADD COLUMN     "decentRegistrationTxId" UUID,
ADD COLUMN     "registrationTxId" UUID;

-- CreateTable
CREATE TABLE "BlockchainTransaction" (
    "id" UUID NOT NULL,
    "txHash" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "status" "DecentTxStatus" NOT NULL,
    "error" JSONB,

    CONSTRAINT "BlockchainTransaction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "BlockchainTransaction_txHash_idx" ON "BlockchainTransaction"("txHash");

-- CreateIndex
CREATE UNIQUE INDEX "BlockchainTransaction_txHash_chainId_key" ON "BlockchainTransaction"("txHash", "chainId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_registrationTxId_key" ON "ScoutMatchup"("registrationTxId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_decentRegistrationTxId_key" ON "ScoutMatchup"("decentRegistrationTxId");

-- AddForeignKey
ALTER TABLE "ScoutMatchup" ADD CONSTRAINT "ScoutMatchup_decentRegistrationTxId_fkey" FOREIGN KEY ("decentRegistrationTxId") REFERENCES "BlockchainTransaction"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutMatchup" ADD CONSTRAINT "ScoutMatchup_registrationTxId_fkey" FOREIGN KEY ("registrationTxId") REFERENCES "BlockchainTransaction"("id") ON DELETE SET NULL ON UPDATE CASCADE;
