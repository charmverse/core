/*
  Warnings:

  - A unique constraint covering the columns `[homePageId]` on the table `Space` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "homePageId" UUID;

-- CreateIndex
CREATE UNIQUE INDEX "Space_homePageId_key" ON "Space"("homePageId");

-- AddForeignKey
ALTER TABLE "Space" ADD CONSTRAINT "Space_homePageId_fkey" FOREIGN KEY ("homePageId") REFERENCES "Page"("id") ON DELETE SET NULL ON UPDATE CASCADE;
