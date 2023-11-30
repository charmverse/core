/*
  Warnings:

  - You are about to drop the column `evaluationType` on the `ProposalEvaluation` table. All the data in the column will be lost.
  - Added the required column `type` to the `ProposalEvaluation` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ProposalEvaluation" DROP COLUMN "evaluationType",
ADD COLUMN     "type" "ProposalEvaluationType" NOT NULL;
