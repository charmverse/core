/*
  Warnings:

  - The primary key for the `ProposalBlock` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `type` column on the `ProposalBlock` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "ProposalBlock" DROP CONSTRAINT "ProposalBlock_pkey",
ALTER COLUMN "id" SET DATA TYPE TEXT,
DROP COLUMN "type",
ADD COLUMN     "type" TEXT NOT NULL DEFAULT 'board',
ADD CONSTRAINT "ProposalBlock_pkey" PRIMARY KEY ("id", "spaceId");

-- DropEnum
DROP TYPE "ProposalBlockType";
