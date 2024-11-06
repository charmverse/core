/*
  Warnings:

  - A unique constraint covering the columns `[telegramId]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "telegramId" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "Scout_telegramId_key" ON "Scout"("telegramId");

-- CreateIndex
CREATE INDEX "Scout_telegramId_idx" ON "Scout"("telegramId");
