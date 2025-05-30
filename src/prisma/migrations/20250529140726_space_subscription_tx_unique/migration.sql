/*
  Warnings:

  - A unique constraint covering the columns `[txHash]` on the table `SpaceSubscriptionContribution` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "SpaceSubscriptionContribution_txHash_key" ON "SpaceSubscriptionContribution"("txHash");
