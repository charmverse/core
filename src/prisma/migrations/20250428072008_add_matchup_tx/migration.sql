/*
  Warnings:

  - A unique constraint covering the columns `[registrationTxHash,registrationTxChainId]` on the table `ScoutMatchup` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[registrationDecentTxHash,registrationDecentTxChainId]` on the table `ScoutMatchup` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "ScoutMatchup" ADD COLUMN     "registrationDecentTxChainId" INTEGER,
ADD COLUMN     "registrationDecentTxHash" TEXT,
ADD COLUMN     "registrationTxChainId" INTEGER,
ADD COLUMN     "registrationTxHash" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_registrationTxHash_registrationTxChainId_key" ON "ScoutMatchup"("registrationTxHash", "registrationTxChainId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_registrationDecentTxHash_registrationDecentTxC_key" ON "ScoutMatchup"("registrationDecentTxHash", "registrationDecentTxChainId");
