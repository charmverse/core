/*
  Warnings:

  - You are about to drop the column `categoryId` on the `Proposal` table. All the data in the column will be lost.
  - You are about to drop the `ProposalCategory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProposalCategoryPermission` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Proposal" DROP CONSTRAINT "Proposal_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalCategory" DROP CONSTRAINT "ProposalCategory_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalCategoryPermission" DROP CONSTRAINT "ProposalCategoryPermission_proposalCategoryId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalCategoryPermission" DROP CONSTRAINT "ProposalCategoryPermission_roleId_fkey";

-- DropForeignKey
ALTER TABLE "ProposalCategoryPermission" DROP CONSTRAINT "ProposalCategoryPermission_spaceId_fkey";

-- DropIndex
DROP INDEX "Proposal_categoryId_idx";

-- AlterTable
ALTER TABLE "Proposal" DROP COLUMN "categoryId";

-- DropTable
DROP TABLE "ProposalCategory";

-- DropTable
DROP TABLE "ProposalCategoryPermission";

-- DropEnum
DROP TYPE "ProposalCategoryOperation";

-- DropEnum
DROP TYPE "ProposalCategoryPermissionLevel";
