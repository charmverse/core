/*
  Warnings:

  - The values [delete,create_vote,vote,review,make_public,archive,unarchive] on the enum `ProposalOperation` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ProposalOperation_new" AS ENUM ('edit', 'view', 'comment', 'evaluate', 'move');
ALTER TABLE "ProposalEvaluationPermission" ALTER COLUMN "operation" TYPE "ProposalOperation_new" USING ("operation"::text::"ProposalOperation_new");
ALTER TYPE "ProposalOperation" RENAME TO "ProposalOperation_old";
ALTER TYPE "ProposalOperation_new" RENAME TO "ProposalOperation";
DROP TYPE "ProposalOperation_old";
COMMIT;
