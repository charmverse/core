-- CreateTable
CREATE TABLE "PendingSafeTransaction" (
    "safeTxHash" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "processed" BOOLEAN NOT NULL DEFAULT false
);

-- CreateIndex
CREATE UNIQUE INDEX "PendingSafeTransaction_safeTxHash_key" ON "PendingSafeTransaction"("safeTxHash");
