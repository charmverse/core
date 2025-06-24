-- CreateEnum
CREATE TYPE "ScoutPartnerStatus" AS ENUM ('active', 'paused', 'completed');

-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "scoutPartnerId" TEXT;

-- AlterTable
ALTER TABLE "GithubRepo" ADD COLUMN     "scoutPartnerId" TEXT;

-- CreateTable
CREATE TABLE "ScoutPartner" (
    "id" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "bannerImage" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "status" "ScoutPartnerStatus" NOT NULL DEFAULT 'active',
    "tokenAmountPerPullRequest" INTEGER,
    "tokenAddress" TEXT,
    "tokenChain" INTEGER,

    CONSTRAINT "ScoutPartner_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubRepo" ADD CONSTRAINT "GithubRepo_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE SET NULL ON UPDATE CASCADE;
