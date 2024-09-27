/*
  Warnings:

  - You are about to drop the column `bannedAt` on the `Scout` table. All the data in the column will be lost.
  - You are about to drop the column `builder` on the `Scout` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Scout" DROP COLUMN "bannedAt",
DROP COLUMN "builder";
