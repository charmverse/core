-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('pending', 'completed', 'failed');

-- CreateTable
CREATE TABLE "PendingNftTransaction" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" UUID NOT NULL,
    "sourceChainTxHash" TEXT NOT NULL,
    "sourceChainId" INTEGER NOT NULL,
    "targetAmountReceived" BIGINT NOT NULL,
    "targetCurrencyContractAddress" TEXT NOT NULL,
    "destinationChainTxHash" TEXT,
    "destinationChainId" INTEGER,
    "contractAddress" TEXT NOT NULL,
    "tokenId" BIGINT NOT NULL,
    "tokenAmount" INTEGER NOT NULL,
    "senderAddress" TEXT NOT NULL,
    "status" "TransactionStatus" NOT NULL DEFAULT 'pending',

    CONSTRAINT "PendingNftTransaction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PendingNftTransaction_userId_idx" ON "PendingNftTransaction"("userId");

-- CreateIndex
CREATE INDEX "PendingNftTransaction_status_idx" ON "PendingNftTransaction"("status");

-- CreateIndex
CREATE UNIQUE INDEX "PendingNftTransaction_sourceChainTxHash_sourceChainId_key" ON "PendingNftTransaction"("sourceChainTxHash", "sourceChainId");

-- CreateIndex
CREATE UNIQUE INDEX "PendingNftTransaction_destinationChainTxHash_destinationCha_key" ON "PendingNftTransaction"("destinationChainTxHash", "destinationChainId");

-- AddForeignKey
ALTER TABLE "PendingNftTransaction" ADD CONSTRAINT "PendingNftTransaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
