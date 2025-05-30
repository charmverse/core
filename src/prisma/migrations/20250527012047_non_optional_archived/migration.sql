/*
  Warnings:

  - Made the column `archived` on table `ProposalWorkflow` required. This step will fail if there are existing NULL values in that column.
  - Made the column `archived` on table `Role` required. This step will fail if there are existing NULL values in that column.
  - Made the column `archived` on table `TokenGate` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "ProposalWorkflow" ALTER COLUMN "archived" SET NOT NULL;

-- AlterTable
ALTER TABLE "Role" ALTER COLUMN "archived" SET NOT NULL;

-- AlterTable
ALTER TABLE "TokenGate" ALTER COLUMN "archived" SET NOT NULL,
ALTER COLUMN "archived" SET DEFAULT false;
