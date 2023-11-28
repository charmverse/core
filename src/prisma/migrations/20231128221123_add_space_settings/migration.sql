/*
  Warnings:

  - Added the required column `title` to the `SpaceProposalWorklow` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SpaceProposalWorklow" ADD COLUMN     "title" TEXT NOT NULL;
