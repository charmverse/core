-- CreateEnum
CREATE TYPE "DecentTxStatus" AS ENUM ('initial', 'pending', 'success', 'failed');

-- CreateTable
CREATE TABLE "DraftSeasonOffer" (
    "id" UUID NOT NULL,
    "season" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "developerId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "makerWalletAddress" TEXT NOT NULL,
    "status" "DecentTxStatus" NOT NULL,
    "decentError" JSONB,
    "decentTxHash" TEXT,
    "txHash" TEXT,
    "completedAt" TIMESTAMP(3),
    "bidRejected" BOOLEAN NOT NULL DEFAULT false,
    "chainId" INTEGER NOT NULL,
    "decentPayload" JSONB NOT NULL,

    CONSTRAINT "DraftSeasonOffer_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "DraftSeasonOffer_season_idx" ON "DraftSeasonOffer"("season");

-- CreateIndex
CREATE INDEX "DraftSeasonOffer_developerId_idx" ON "DraftSeasonOffer"("developerId");

-- CreateIndex
CREATE INDEX "DraftSeasonOffer_status_idx" ON "DraftSeasonOffer"("status");

-- CreateIndex
CREATE INDEX "DraftSeasonOffer_createdBy_idx" ON "DraftSeasonOffer"("createdBy");

-- AddForeignKey
ALTER TABLE "DraftSeasonOffer" ADD CONSTRAINT "DraftSeasonOffer_developerId_fkey" FOREIGN KEY ("developerId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DraftSeasonOffer" ADD CONSTRAINT "DraftSeasonOffer_makerWalletAddress_fkey" FOREIGN KEY ("makerWalletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
