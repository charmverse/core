/*
  Warnings:

  - Made the column `season` on table `PointsReceipt` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "PointsReceipt" ALTER COLUMN "season" SET NOT NULL;
