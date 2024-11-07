-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'daily_claim';

-- AlterTable
ALTER TABLE "Scout" ALTER COLUMN "telegramId" SET DATA TYPE BIGINT;

-- CreateTable
CREATE TABLE "ScoutSocialQuest" (
    "type" TEXT NOT NULL,
    "userId" UUID NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutSocialQuest_userId_idx" ON "ScoutSocialQuest"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutSocialQuest_type_userId_key" ON "ScoutSocialQuest"("type", "userId");

-- AddForeignKey
ALTER TABLE "ScoutSocialQuest" ADD CONSTRAINT "ScoutSocialQuest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
