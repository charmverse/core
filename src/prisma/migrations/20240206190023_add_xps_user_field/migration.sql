/*
  Warnings:

  - A unique constraint covering the columns `[xpsUserId]` on the table `SpaceRole` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "SpaceRole" ADD COLUMN     "xpsUserId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "SpaceRole_xpsUserId_key" ON "SpaceRole"("xpsUserId");
