/*
  Warnings:

  - A unique constraint covering the columns `[dailyClaimEventId]` on the table `BuilderEvent` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[dailyClaimStreakEventId]` on the table `BuilderEvent` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[scoutSocialQuestId]` on the table `BuilderEvent` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "BuilderEventType" ADD VALUE 'daily_claim';
ALTER TYPE "BuilderEventType" ADD VALUE 'daily_claim_streak';
ALTER TYPE "BuilderEventType" ADD VALUE 'social_quest';

-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "dailyClaimEventId" UUID,
ADD COLUMN     "dailyClaimStreakEventId" UUID,
ADD COLUMN     "scoutSocialQuestId" UUID;

-- AlterTable
ALTER TABLE "Scout" ALTER COLUMN "telegramId" SET DATA TYPE BIGINT;

-- CreateTable
CREATE TABLE "ScoutSocialQuest" (
    "id" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScoutSocialQuest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutDailyClaimEvent" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "week" TEXT NOT NULL,
    "dayOfWeek" INTEGER NOT NULL,

    CONSTRAINT "ScoutDailyClaimEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutDailyClaimStreakEvent" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "week" TEXT NOT NULL,

    CONSTRAINT "ScoutDailyClaimStreakEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutSocialQuest_userId_idx" ON "ScoutSocialQuest"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutSocialQuest_type_userId_key" ON "ScoutSocialQuest"("type", "userId");

-- CreateIndex
CREATE INDEX "ScoutDailyClaimEvent_userId_week_idx" ON "ScoutDailyClaimEvent"("userId", "week");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutDailyClaimEvent_userId_week_dayOfWeek_key" ON "ScoutDailyClaimEvent"("userId", "week", "dayOfWeek");

-- CreateIndex
CREATE INDEX "ScoutDailyClaimStreakEvent_userId_week_idx" ON "ScoutDailyClaimStreakEvent"("userId", "week");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutDailyClaimStreakEvent_userId_week_key" ON "ScoutDailyClaimStreakEvent"("userId", "week");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderEvent_dailyClaimEventId_key" ON "BuilderEvent"("dailyClaimEventId");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderEvent_dailyClaimStreakEventId_key" ON "BuilderEvent"("dailyClaimStreakEventId");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderEvent_scoutSocialQuestId_key" ON "BuilderEvent"("scoutSocialQuestId");

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_dailyClaimEventId_fkey" FOREIGN KEY ("dailyClaimEventId") REFERENCES "ScoutDailyClaimEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_dailyClaimStreakEventId_fkey" FOREIGN KEY ("dailyClaimStreakEventId") REFERENCES "ScoutDailyClaimStreakEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_scoutSocialQuestId_fkey" FOREIGN KEY ("scoutSocialQuestId") REFERENCES "ScoutSocialQuest"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutSocialQuest" ADD CONSTRAINT "ScoutSocialQuest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutDailyClaimEvent" ADD CONSTRAINT "ScoutDailyClaimEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutDailyClaimStreakEvent" ADD CONSTRAINT "ScoutDailyClaimStreakEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
