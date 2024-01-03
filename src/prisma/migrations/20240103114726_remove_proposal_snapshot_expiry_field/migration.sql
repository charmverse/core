/*
  Warnings:

  - You are about to drop the column `snapshotProposalExpiry` on the `Proposal` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Proposal" DROP COLUMN "snapshotProposalExpiry";
