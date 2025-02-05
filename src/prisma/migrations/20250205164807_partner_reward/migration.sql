-- CreateTable
CREATE TABLE "PartnerReward" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "season" TEXT NOT NULL,
    "week" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "contractAddress" TEXT NOT NULL,
    "tokenAddress" TEXT NOT NULL,
    "partner" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "txHash" TEXT NOT NULL,
    "claimedAt" TIMESTAMP(3),

    CONSTRAINT "PartnerReward_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PartnerReward_userId_idx" ON "PartnerReward"("userId");

-- CreateIndex
CREATE INDEX "PartnerReward_contractAddress_idx" ON "PartnerReward"("contractAddress");

-- CreateIndex
CREATE INDEX "PartnerReward_chainId_idx" ON "PartnerReward"("chainId");

-- CreateIndex
CREATE INDEX "PartnerReward_claimedAt_idx" ON "PartnerReward"("claimedAt");

-- CreateIndex
CREATE UNIQUE INDEX "PartnerReward_userId_contractAddress_chainId_partner_key" ON "PartnerReward"("userId", "contractAddress", "chainId", "partner");

-- AddForeignKey
ALTER TABLE "PartnerReward" ADD CONSTRAINT "PartnerReward_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
