/*
  Warnings:

  - A unique constraint covering the columns `[path]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "path" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Scout_path_key" ON "Scout"("path");

-- CreateIndex
CREATE INDEX "Scout_path_idx" ON "Scout"("path");
