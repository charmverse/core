/*
  Warnings:

  - A unique constraint covering the columns `[customDomain]` on the table `Space` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "customDomain" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Space_customDomain_key" ON "Space"("customDomain");
