-- CreateTable
CREATE TABLE "ScoutNft" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "builderId" UUID NOT NULL,
    "contract" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "season" INTEGER NOT NULL,
    "contractAddress" TEXT NOT NULL,
    "tokenId" INTEGER NOT NULL,

    CONSTRAINT "ScoutNft_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ScoutNft_contractAddress_tokenId_chainId_key" ON "ScoutNft"("contractAddress", "tokenId", "chainId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutNft_builderId_season_key" ON "ScoutNft"("builderId", "season");

-- AddForeignKey
ALTER TABLE "ScoutNft" ADD CONSTRAINT "ScoutNft_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
