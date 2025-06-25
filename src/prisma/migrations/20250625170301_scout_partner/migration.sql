-- CreateEnum
CREATE TYPE "ScoutPartnerStatus" AS ENUM ('active', 'paused', 'completed');

-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "scoutPartnerId" TEXT;

-- AlterTable
ALTER TABLE "GithubRepo" ADD COLUMN     "scoutPartnerId" TEXT;

-- AlterTable
ALTER TABLE "PartnerRewardEvent" ADD COLUMN     "scoutPartnerId" TEXT;

-- AlterTable
ALTER TABLE "PartnerRewardPayoutContract" ADD COLUMN     "scoutPartnerId" TEXT;

-- CreateTable
CREATE TABLE "ScoutPartner" (
    "id" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "bannerImage" TEXT NOT NULL,
    "infoPageImage" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "status" "ScoutPartnerStatus" NOT NULL DEFAULT 'active',
    "tokenAmountPerPullRequest" INTEGER,
    "tokenAddress" TEXT,
    "tokenChain" INTEGER,
    "tokenSymbol" TEXT,
    "tokenDecimals" INTEGER,
    "tokenImage" TEXT,
    "issueTagTokenAmounts" JSONB DEFAULT '{}',

    CONSTRAINT "ScoutPartner_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "BuilderEvent_scoutPartnerId_idx" ON "BuilderEvent"("scoutPartnerId");

-- CreateIndex
CREATE INDEX "GithubRepo_scoutPartnerId_idx" ON "GithubRepo"("scoutPartnerId");

-- CreateIndex
CREATE INDEX "PartnerRewardEvent_scoutPartnerId_idx" ON "PartnerRewardEvent"("scoutPartnerId");

-- CreateIndex
CREATE INDEX "PartnerRewardPayoutContract_scoutPartnerId_idx" ON "PartnerRewardPayoutContract"("scoutPartnerId");

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubRepo" ADD CONSTRAINT "GithubRepo_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartnerRewardEvent" ADD CONSTRAINT "PartnerRewardEvent_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartnerRewardPayoutContract" ADD CONSTRAINT "PartnerRewardPayoutContract_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE SET NULL ON UPDATE CASCADE;
