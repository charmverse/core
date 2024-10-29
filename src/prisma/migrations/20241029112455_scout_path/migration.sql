/*
  Warnings:

  - A unique constraint covering the columns `[path]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "Scout_username_idx";

-- DropIndex
DROP INDEX "Scout_username_key";

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "path" TEXT,
ALTER COLUMN "username" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Scout_path_key" ON "Scout"("path");

-- CreateIndex
CREATE INDEX "Scout_path_idx" ON "Scout"("path");
