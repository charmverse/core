-- CreateEnum
CREATE TYPE "BuilderEventType" AS ENUM ('github_event', 'waitlist_airdrop', 'nft_purchase', 'proposal_passed', 'gems_payout');

-- CreateEnum
CREATE TYPE "GithubEventType" AS ENUM ('merged_pull_request');

-- CreateEnum
CREATE TYPE "GemReceiptType" AS ENUM ('first_pr', 'third_pr_in_streak', 'regular_pr');

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
    "week" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "githubEventId" TEXT,
    "gemsPayoutEventId" UUID,

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

-- CreateTable
CREATE TABLE "GemsPayoutEvent" (
    "id" UUID NOT NULL,
    "builderId" UUID NOT NULL,
    "gems" INTEGER NOT NULL,
    "points" INTEGER NOT NULL,
    "week" TEXT NOT NULL,

    CONSTRAINT "GemsPayoutEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PointsReceipt" (
    "id" UUID NOT NULL,
    "eventId" UUID NOT NULL,
    "recipientId" UUID NOT NULL,
    "senderId" UUID NOT NULL,
    "claimedAt" TIMESTAMP(3) NOT NULL,
    "scoutId" UUID,

    CONSTRAINT "PointsReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GemReceipt" (
    "id" UUID NOT NULL,
    "eventId" UUID NOT NULL,
    "value" INTEGER NOT NULL,
    "type" "GemReceiptType" NOT NULL,

    CONSTRAINT "GemReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserWeeklyStats" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "gemsCollected" INTEGER NOT NULL,
    "week" TEXT NOT NULL,

    CONSTRAINT "UserWeeklyStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSeasonStats" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "pointsEarnedAsBuilder" INTEGER NOT NULL,
    "pointsEarnedAsScout" INTEGER NOT NULL,
    "season" INTEGER NOT NULL,

    CONSTRAINT "UserSeasonStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAllTimeStats" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "pointsEarnedAsBuilder" INTEGER NOT NULL,
    "pointsEarnedAsScout" INTEGER NOT NULL,
    "currentBalance" INTEGER NOT NULL,

    CONSTRAINT "UserAllTimeStats_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "BuilderStrike_builderId_deletedAt_idx" ON "BuilderStrike"("builderId", "deletedAt");

-- CreateIndex
CREATE INDEX "BuilderEvent_builderId_idx" ON "BuilderEvent"("builderId");

-- CreateIndex
CREATE INDEX "BuilderEvent_githubEventId_idx" ON "BuilderEvent"("githubEventId");

-- CreateIndex
CREATE INDEX "BuilderEvent_gemsPayoutEventId_idx" ON "BuilderEvent"("gemsPayoutEventId");

-- CreateIndex
CREATE INDEX "GithubUser_builderId_idx" ON "GithubUser"("builderId");

-- CreateIndex
CREATE INDEX "GithubEvent_repoId_idx" ON "GithubEvent"("repoId");

-- CreateIndex
CREATE INDEX "GithubEvent_createdBy_idx" ON "GithubEvent"("createdBy");

-- CreateIndex
CREATE INDEX "GemsPayoutEvent_builderId_idx" ON "GemsPayoutEvent"("builderId");

-- CreateIndex
CREATE UNIQUE INDEX "GemsPayoutEvent_builderId_week_key" ON "GemsPayoutEvent"("builderId", "week");

-- CreateIndex
CREATE INDEX "UserWeeklyStats_userId_idx" ON "UserWeeklyStats"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserWeeklyStats_userId_week_key" ON "UserWeeklyStats"("userId", "week");

-- CreateIndex
CREATE INDEX "UserSeasonStats_userId_idx" ON "UserSeasonStats"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserSeasonStats_userId_season_key" ON "UserSeasonStats"("userId", "season");

-- AddForeignKey
ALTER TABLE "BuilderStrike" ADD CONSTRAINT "BuilderStrike_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderStrike" ADD CONSTRAINT "BuilderStrike_builderEventId_fkey" FOREIGN KEY ("builderEventId") REFERENCES "BuilderEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_githubEventId_fkey" FOREIGN KEY ("githubEventId") REFERENCES "GithubEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_gemsPayoutEventId_fkey" FOREIGN KEY ("gemsPayoutEventId") REFERENCES "GemsPayoutEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubUser" ADD CONSTRAINT "GithubUser_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubEvent" ADD CONSTRAINT "GithubEvent_repoId_fkey" FOREIGN KEY ("repoId") REFERENCES "GithubRepo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubEvent" ADD CONSTRAINT "GithubEvent_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "GithubUser"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GemsPayoutEvent" ADD CONSTRAINT "GemsPayoutEvent_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PointsReceipt" ADD CONSTRAINT "PointsReceipt_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "BuilderEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PointsReceipt" ADD CONSTRAINT "PointsReceipt_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PointsReceipt" ADD CONSTRAINT "PointsReceipt_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PointsReceipt" ADD CONSTRAINT "PointsReceipt_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GemReceipt" ADD CONSTRAINT "GemReceipt_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "BuilderEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserWeeklyStats" ADD CONSTRAINT "UserWeeklyStats_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSeasonStats" ADD CONSTRAINT "UserSeasonStats_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAllTimeStats" ADD CONSTRAINT "UserAllTimeStats_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
