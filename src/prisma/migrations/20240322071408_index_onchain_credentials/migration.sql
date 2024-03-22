-- CreateTable
CREATE TABLE "PendingSafeTransaction" (
    "safeAddress" TEXT NOT NULL,
    "safeTxHash" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "processed" BOOLEAN NOT NULL DEFAULT false,
    "spaceId" UUID NOT NULL,
    "schemaId" TEXT NOT NULL,
    "proposalIds" TEXT[],
    "credentialContent" JSONB
);

-- CreateIndex
CREATE UNIQUE INDEX "PendingSafeTransaction_safeTxHash_key" ON "PendingSafeTransaction"("safeTxHash");

-- CreateIndex
CREATE INDEX "PendingSafeTransaction_spaceId_idx" ON "PendingSafeTransaction"("spaceId");

-- CreateIndex
CREATE INDEX "PendingSafeTransaction_proposalIds_idx" ON "PendingSafeTransaction" USING GIN ("proposalIds");

-- AddForeignKey
ALTER TABLE "PendingSafeTransaction" ADD CONSTRAINT "PendingSafeTransaction_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
