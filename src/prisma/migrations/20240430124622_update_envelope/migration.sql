/*
  Warnings:

  - Added the required column `spaceId` to the `DocumentToSign` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "DocumentToSign" ADD COLUMN     "spaceId" UUID NOT NULL;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
