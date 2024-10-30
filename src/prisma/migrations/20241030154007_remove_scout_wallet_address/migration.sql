/*
  Warnings:

  - You are about to drop the column `walletAddress` on the `Scout` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Scout_walletAddress_idx";

-- AlterTable
ALTER TABLE "Scout" DROP COLUMN "walletAddress";
