/*
  Warnings:

  - You are about to drop the column `farcasterName` on the `Scout` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[farcasterUsername]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Scout" DROP COLUMN "farcasterName",
ADD COLUMN     "farcasterUsername" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Scout_farcasterUsername_key" ON "Scout"("farcasterUsername");
