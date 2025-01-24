/*
  Warnings:

  - A unique constraint covering the columns `[path]` on the table `ScoutProject` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "ScoutProject" ADD COLUMN     "path" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "avatar" SET DEFAULT '',
ALTER COLUMN "description" SET DEFAULT '',
ALTER COLUMN "website" SET DEFAULT '',
ALTER COLUMN "github" SET DEFAULT '';

-- AlterTable
ALTER TABLE "ScoutProjectContract" ALTER COLUMN "blockNumber" SET DATA TYPE BIGINT;

-- AlterTable
ALTER TABLE "ScoutProjectContractTransaction" ALTER COLUMN "blockNumber" SET DATA TYPE BIGINT;

-- CreateIndex
CREATE INDEX "ScoutProject_path_idx" ON "ScoutProject"("path");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProject_path_key" ON "ScoutProject"("path");
