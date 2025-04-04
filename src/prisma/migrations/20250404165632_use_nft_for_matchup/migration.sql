/*
  Warnings:

  - Added the required column `developerNftId` to the `ScoutMatchupSelection` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ScoutMatchupSelection" ADD COLUMN     "developerNftId" UUID NOT NULL,
ALTER COLUMN "developerId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "ScoutMatchupSelection" ADD CONSTRAINT "ScoutMatchupSelection_developerNftId_fkey" FOREIGN KEY ("developerNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;
