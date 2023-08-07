-- CreateEnum
CREATE TYPE "ProposalEvaluationType" AS ENUM ('vote', 'evaluation');

-- CreateEnum
CREATE TYPE "ProposalRubricCriteriaType" AS ENUM ('range');

-- AlterEnum
ALTER TYPE "ProposalOperation" ADD VALUE 'evaluate';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ProposalStatus" ADD VALUE 'evaluation_active';
ALTER TYPE "ProposalStatus" ADD VALUE 'evaluation_closed';

-- AlterTable
ALTER TABLE "Page" ADD COLUMN     "sourceTemplateId" UUID;

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "evaluationType" "ProposalEvaluationType" NOT NULL DEFAULT 'vote';

-- CreateTable
CREATE TABLE "ProposalRubricCriteria" (
    "id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "proposalId" UUID NOT NULL,
    "type" "ProposalRubricCriteriaType" NOT NULL,
    "parameters" JSONB NOT NULL,

    CONSTRAINT "ProposalRubricCriteria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProposalRubricCriteriaAnswer" (
    "rubricCriteriaId" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "userId" TEXT NOT NULL,
    "response" JSONB NOT NULL
);

-- CreateIndex
CREATE INDEX "ProposalRubricCriteria_proposalId_idx" ON "ProposalRubricCriteria"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalRubricCriteriaAnswer_proposalId_idx" ON "ProposalRubricCriteriaAnswer"("proposalId");

-- CreateIndex
CREATE INDEX "ProposalRubricCriteriaAnswer_rubricCriteriaId_idx" ON "ProposalRubricCriteriaAnswer"("rubricCriteriaId");

-- CreateIndex
CREATE UNIQUE INDEX "ProposalRubricCriteriaAnswer_userId_rubricCriteriaId_key" ON "ProposalRubricCriteriaAnswer"("userId", "rubricCriteriaId");

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteria" ADD CONSTRAINT "ProposalRubricCriteria_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD CONSTRAINT "ProposalRubricCriteriaAnswer_rubricCriteriaId_fkey" FOREIGN KEY ("rubricCriteriaId") REFERENCES "ProposalRubricCriteria"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD CONSTRAINT "ProposalRubricCriteriaAnswer_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;
