-- CreateTable
CREATE TABLE "PartnerRewardPayout" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "amount" TEXT NOT NULL,
    "claimedAt" TIMESTAMP(3),
    "txHash" TEXT,
    "payoutContractId" UUID NOT NULL,
    "meta" JSONB,

    CONSTRAINT "PartnerRewardPayout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PartnerRewardPayoutContract" (
    "id" UUID NOT NULL,
    "season" TEXT NOT NULL,
    "week" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "contractAddress" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "tokenAddress" TEXT NOT NULL,
    "tokenDecimals" INTEGER NOT NULL,
    "partner" TEXT NOT NULL,
    "deployTxHash" TEXT NOT NULL,
    "cid" TEXT NOT NULL,

    CONSTRAINT "PartnerRewardPayoutContract_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PartnerRewardPayout_userId_idx" ON "PartnerRewardPayout"("userId");

-- CreateIndex
CREATE INDEX "PartnerRewardPayout_payoutContractId_idx" ON "PartnerRewardPayout"("payoutContractId");

-- AddForeignKey
ALTER TABLE "PartnerRewardPayout" ADD CONSTRAINT "PartnerRewardPayout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartnerRewardPayout" ADD CONSTRAINT "PartnerRewardPayout_payoutContractId_fkey" FOREIGN KEY ("payoutContractId") REFERENCES "PartnerRewardPayoutContract"("id") ON DELETE CASCADE ON UPDATE CASCADE;
