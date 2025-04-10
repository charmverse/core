-- CreateTable
CREATE TABLE "AirdropClaim" (
    "id" UUID NOT NULL,
    "season" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "contractAddress" TEXT NOT NULL,
    "blockNumber" BIGINT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "deployTxHash" TEXT NOT NULL,
    "merkleTreeUrl" TEXT NOT NULL,

    CONSTRAINT "AirdropClaim_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AirdropClaimPayout" (
    "id" UUID NOT NULL,
    "airdropClaimId" UUID NOT NULL,
    "claimAmount" TEXT NOT NULL,
    "donationAmount" TEXT NOT NULL,
    "claimTxHash" TEXT NOT NULL,
    "donationTxHash" TEXT,
    "walletAddress" TEXT NOT NULL,
    "claimedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AirdropClaimPayout_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "AirdropClaimPayout_airdropClaimId_idx" ON "AirdropClaimPayout"("airdropClaimId");

-- CreateIndex
CREATE INDEX "AirdropClaimPayout_claimTxHash_idx" ON "AirdropClaimPayout"("claimTxHash");

-- CreateIndex
CREATE UNIQUE INDEX "AirdropClaimPayout_airdropClaimId_walletAddress_key" ON "AirdropClaimPayout"("airdropClaimId", "walletAddress");

-- AddForeignKey
ALTER TABLE "AirdropClaimPayout" ADD CONSTRAINT "AirdropClaimPayout_airdropClaimId_fkey" FOREIGN KEY ("airdropClaimId") REFERENCES "AirdropClaim"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AirdropClaimPayout" ADD CONSTRAINT "AirdropClaimPayout_walletAddress_fkey" FOREIGN KEY ("walletAddress") REFERENCES "ScoutWallet"("address") ON DELETE CASCADE ON UPDATE CASCADE;
