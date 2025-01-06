/*
  Warnings:

  - A unique constraint covering the columns `[type,userId,season]` on the table `ScoutSocialQuest` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "ScoutSocialQuest_type_userId_key";

-- AlterTable
ALTER TABLE "ScoutSocialQuest" ADD COLUMN     "season" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "ScoutSocialQuest_type_userId_season_key" ON "ScoutSocialQuest"("type", "userId", "season");
