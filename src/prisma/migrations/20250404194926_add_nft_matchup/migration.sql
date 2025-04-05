/*
  Warnings:

  - A unique constraint covering the columns `[matchupId,developerNftId]` on the table `ScoutMatchupSelection` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "ScoutMatchupSelection" ADD COLUMN     "developerNftId" UUID,
ALTER COLUMN "developerId" DROP NOT NULL;

-- CreateIndex
CREATE INDEX "ScoutMatchupSelection_developerNftId_idx" ON "ScoutMatchupSelection"("developerNftId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchupSelection_matchupId_developerNftId_key" ON "ScoutMatchupSelection"("matchupId", "developerNftId");

-- AddForeignKey
ALTER TABLE "ScoutMatchupSelection" ADD CONSTRAINT "ScoutMatchupSelection_developerNftId_fkey" FOREIGN KEY ("developerNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;
