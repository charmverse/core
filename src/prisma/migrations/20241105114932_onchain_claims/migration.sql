-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "weeklyClaimId" UUID;

-- AlterTable
ALTER TABLE "GemsReceipt" ADD COLUMN     "onchainAttestationRevoked" BOOLEAN DEFAULT false,
ADD COLUMN     "onchainAttestationUid" TEXT,
ADD COLUMN     "onchainChainId" INTEGER;

-- AlterTable
ALTER TABLE "ScoutGameActivity" ADD COLUMN     "tokensReceiptId" UUID;

-- CreateTable
CREATE TABLE "WeeklyClaims" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "season" TEXT NOT NULL,
    "week" TEXT NOT NULL,
    "merkleTreeRoot" TEXT NOT NULL,
    "totalClaimable" INTEGER NOT NULL,
    "claims" JSONB NOT NULL,
    "proofsMap" JSONB NOT NULL,

    CONSTRAINT "WeeklyClaims_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TokensReceipt" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "value" INTEGER NOT NULL,
    "claimedAt" TIMESTAMP(3),
    "eventId" UUID NOT NULL,
    "recipientId" UUID,
    "senderId" UUID,

    CONSTRAINT "TokensReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "WeeklyClaims_week_key" ON "WeeklyClaims"("week");

-- CreateIndex
CREATE INDEX "TokensReceipt_recipientId_idx" ON "TokensReceipt"("recipientId");

-- CreateIndex
CREATE INDEX "TokensReceipt_senderId_idx" ON "TokensReceipt"("senderId");

-- CreateIndex
CREATE INDEX "TokensReceipt_eventId_idx" ON "TokensReceipt"("eventId");

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_weeklyClaimId_fkey" FOREIGN KEY ("weeklyClaimId") REFERENCES "WeeklyClaims"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutGameActivity" ADD CONSTRAINT "ScoutGameActivity_tokensReceiptId_fkey" FOREIGN KEY ("tokensReceiptId") REFERENCES "TokensReceipt"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TokensReceipt" ADD CONSTRAINT "TokensReceipt_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "BuilderEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TokensReceipt" ADD CONSTRAINT "TokensReceipt_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TokensReceipt" ADD CONSTRAINT "TokensReceipt_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
