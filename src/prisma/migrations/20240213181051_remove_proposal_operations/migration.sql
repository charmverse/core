/*
  Warnings:

  - The values [vote,review,make_public] on the enum `ProposalOperation` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ProposalOperation_new" AS ENUM ('edit', 'view', 'view_private_fields', 'delete', 'create_vote', 'comment', 'evaluate', 'archive', 'unarchive', 'move');
ALTER TABLE "ProposalEvaluationPermission" ALTER COLUMN "operation" TYPE "ProposalOperation_new" USING ("operation"::text::"ProposalOperation_new");
ALTER TYPE "ProposalOperation" RENAME TO "ProposalOperation_old";
ALTER TYPE "ProposalOperation_new" RENAME TO "ProposalOperation";
DROP TYPE "ProposalOperation_old";
COMMIT;
