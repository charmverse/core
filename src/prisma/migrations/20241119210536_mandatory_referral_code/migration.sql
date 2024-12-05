/*
  Warnings:

  - Made the column `referralCode` on table `Scout` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Scout" ALTER COLUMN "referralCode" SET NOT NULL;
