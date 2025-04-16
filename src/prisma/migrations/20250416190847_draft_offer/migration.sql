/*
  Warnings:

  - You are about to drop the column `bidRejected` on the `DraftSeasonOffer` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "DraftSeasonOffer" DROP COLUMN "bidRejected",
ADD COLUMN     "sourceChainId" INTEGER,
ALTER COLUMN "chainId" DROP NOT NULL;
