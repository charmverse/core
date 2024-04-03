/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.
  - The `walletAddress` column on the `Project` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Page" DROP COLUMN "pageId";

-- AlterTable
ALTER TABLE "Project" DROP COLUMN "walletAddress",
ADD COLUMN     "walletAddress" JSONB;
