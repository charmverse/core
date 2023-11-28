/*
  Warnings:

  - Added the required column `index` to the `SpaceProposalWorklow` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SpaceProposalWorklow" ADD COLUMN     "index" INTEGER NOT NULL;
