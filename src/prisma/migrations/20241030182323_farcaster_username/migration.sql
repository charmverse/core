/*
  Warnings:

  - A unique constraint covering the columns `[farcasterUsername]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "farcasterUsername" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Scout_farcasterUsername_key" ON "Scout"("farcasterUsername");
