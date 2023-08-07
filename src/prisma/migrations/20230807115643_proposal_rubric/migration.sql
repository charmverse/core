-- CreateEnum
CREATE TYPE "ProposalEvaluationType" AS ENUM ('vote', 'evaluation');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ProposalOperation" ADD VALUE 'evaluate';
ALTER TYPE "ProposalOperation" ADD VALUE 'configure_rubric';

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "evaluationType" "ProposalEvaluationType" NOT NULL DEFAULT 'vote',
ADD COLUMN     "rubricAnswers" JSONB,
ADD COLUMN     "rubricQuestions" JSONB;
