/*
  Warnings:

  - You are about to drop the `SpaceProposalWorkflow` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "SpaceProposalWorkflow" DROP CONSTRAINT "SpaceProposalWorkflow_spaceId_fkey";

-- DropTable
DROP TABLE "SpaceProposalWorkflow";

-- CreateTable
CREATE TABLE "ProposalWorkflowTemplate" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "index" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "evaluations" JSONB[],

    CONSTRAINT "ProposalWorkflowTemplate_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ProposalWorkflowTemplate" ADD CONSTRAINT "ProposalWorkflowTemplate_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
