-- CreateEnum
CREATE TYPE "BuilderEventType" AS ENUM ('github_event', 'waitlist_airdrop', 'nft_purchase', 'proposal_passed', 'gems_payout');

-- CreateEnum
CREATE TYPE "GithubEventType" AS ENUM ('merged_pull_request');

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "bannedAt" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "BuilderStrike" (
    "id" UUID NOT NULL,
    "builderId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),
    "builderEventId" UUID NOT NULL,

    CONSTRAINT "BuilderStrike_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BuilderEvent" (
    "id" UUID NOT NULL,
    "builderId" UUID NOT NULL,
    "season" INTEGER NOT NULL,
    "type" "BuilderEventType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "githubEventId" TEXT,

    CONSTRAINT "BuilderEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GithubUser" (
    "id" INTEGER NOT NULL,
    "builderId" UUID,
    "email" TEXT,
    "displayName" TEXT,
    "login" TEXT NOT NULL,

    CONSTRAINT "GithubUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GithubRepo" (
    "id" TEXT NOT NULL,
    "owner" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "GithubRepo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GithubEvent" (
    "id" TEXT NOT NULL,
    "repoId" TEXT NOT NULL,
    "pullRequestNumber" INTEGER NOT NULL,
    "type" "GithubEventType" NOT NULL,
    "title" TEXT NOT NULL,
    "createdBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GithubEvent_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "BuilderStrike" ADD CONSTRAINT "BuilderStrike_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderStrike" ADD CONSTRAINT "BuilderStrike_builderEventId_fkey" FOREIGN KEY ("builderEventId") REFERENCES "BuilderEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_githubEventId_fkey" FOREIGN KEY ("githubEventId") REFERENCES "GithubEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubUser" ADD CONSTRAINT "GithubUser_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubEvent" ADD CONSTRAINT "GithubEvent_repoId_fkey" FOREIGN KEY ("repoId") REFERENCES "GithubRepo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubEvent" ADD CONSTRAINT "GithubEvent_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "GithubUser"("id") ON DELETE CASCADE ON UPDATE CASCADE;
