/*
  Warnings:

  - Added the required column `title` to the `CryptoEcosystemPullRequest` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CryptoEcosystemPullRequest" ADD COLUMN     "title" TEXT NOT NULL,
ALTER COLUMN "githubId" SET DATA TYPE TEXT;
