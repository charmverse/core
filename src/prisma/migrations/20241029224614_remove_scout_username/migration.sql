/*
  Warnings:

  - You are about to drop the column `username` on the `Scout` table. All the data in the column will be lost.
  - Made the column `path` on table `Scout` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Scout" DROP COLUMN "username",
ALTER COLUMN "path" SET NOT NULL;
