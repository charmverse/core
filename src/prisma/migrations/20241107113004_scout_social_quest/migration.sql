-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "BuilderEventType" ADD VALUE 'daily_claim';
ALTER TYPE "BuilderEventType" ADD VALUE 'social_quest';

-- AlterTable
ALTER TABLE "Scout" ALTER COLUMN "telegramId" SET DATA TYPE BIGINT;

-- CreateTable
CREATE TABLE "ScoutSocialQuest" (
    "type" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE INDEX "ScoutSocialQuest_userId_idx" ON "ScoutSocialQuest"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutSocialQuest_type_userId_key" ON "ScoutSocialQuest"("type", "userId");

-- AddForeignKey
ALTER TABLE "ScoutSocialQuest" ADD CONSTRAINT "ScoutSocialQuest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
