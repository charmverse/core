/*
  Warnings:

  - Made the column `chainType` on table `ScoutProjectWallet` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "ScoutProjectWallet" ALTER COLUMN "chainType" SET NOT NULL;
