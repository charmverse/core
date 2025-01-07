/*
  Warnings:

  - Made the column `season` on table `ScoutSocialQuest` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "ScoutSocialQuest" ALTER COLUMN "season" SET NOT NULL;
