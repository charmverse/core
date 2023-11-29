/*
  Warnings:

  - A unique constraint covering the columns `[safeTxHash]` on the table `Transaction` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Transaction_safeTxHash_key" ON "Transaction"("safeTxHash");
