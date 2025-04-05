/*
  Warnings:

  - You are about to drop the column `developerId` on the `ScoutMatchupSelection` table. All the data in the column will be lost.
  - Made the column `developerNftId` on table `ScoutMatchupSelection` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "ScoutMatchupSelection" DROP CONSTRAINT "ScoutMatchupSelection_developerId_fkey";

-- DropIndex
DROP INDEX "ScoutMatchupSelection_developerId_idx";

-- DropIndex
DROP INDEX "ScoutMatchupSelection_matchupId_developerId_key";

-- AlterTable
ALTER TABLE "ScoutMatchupSelection" DROP COLUMN "developerId",
ALTER COLUMN "developerNftId" SET NOT NULL;
