/*
  Warnings:

  - You are about to drop the `SpaceProposalWorklow` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "SpaceProposalWorklow" DROP CONSTRAINT "SpaceProposalWorklow_spaceId_fkey";

-- DropTable
DROP TABLE "SpaceProposalWorklow";

-- CreateTable
CREATE TABLE "SpaceProposalWorkflow" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "evaluations" JSONB[],

    CONSTRAINT "SpaceProposalWorkflow_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceProposalWorkflow" ADD CONSTRAINT "SpaceProposalWorkflow_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
