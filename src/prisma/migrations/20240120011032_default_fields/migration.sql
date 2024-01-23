/*
  Warnings:

  - Made the column `fields` on table `Proposal` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Proposal" ALTER COLUMN "fields" SET NOT NULL,
ALTER COLUMN "fields" SET DEFAULT '{}';
