/*
  Warnings:

  - Added the required column `title` to the `ProposalEvaluation` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ProposalEvaluation" ADD COLUMN     "title" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "SpaceProposalWorklow" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "evaluations" JSONB[],

    CONSTRAINT "SpaceProposalWorklow_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceProposalWorklow" ADD CONSTRAINT "SpaceProposalWorklow_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
