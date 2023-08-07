/*
  Warnings:

  - The values [evaluation] on the enum `ProposalEvaluationType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ProposalEvaluationType_new" AS ENUM ('vote', 'rubric');
ALTER TABLE "Proposal" ALTER COLUMN "evaluationType" DROP DEFAULT;
ALTER TABLE "Proposal" ALTER COLUMN "evaluationType" TYPE "ProposalEvaluationType_new" USING ("evaluationType"::text::"ProposalEvaluationType_new");
ALTER TYPE "ProposalEvaluationType" RENAME TO "ProposalEvaluationType_old";
ALTER TYPE "ProposalEvaluationType_new" RENAME TO "ProposalEvaluationType";
DROP TYPE "ProposalEvaluationType_old";
ALTER TABLE "Proposal" ALTER COLUMN "evaluationType" SET DEFAULT 'vote';
COMMIT;
