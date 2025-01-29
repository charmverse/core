/*
  Warnings:

  - A unique constraint covering the columns `[path]` on the table `ScoutProject` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `path` to the `ScoutProject` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ScoutProject" ADD COLUMN     "path" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProject_path_key" ON "ScoutProject"("path");
