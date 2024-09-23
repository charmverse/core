/*
  Warnings:

  - You are about to drop the column `currentBalance` on the `UserAllTimeStats` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "PointsReceipt" ALTER COLUMN "claimedAt" DROP NOT NULL,
ALTER COLUMN "recipientId" DROP NOT NULL,
ALTER COLUMN "senderId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "currentBalance" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "UserAllTimeStats" DROP COLUMN "currentBalance";
