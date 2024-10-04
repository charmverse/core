/*
  Warnings:

  - A unique constraint covering the columns `[owner,name]` on the table `GithubRepo` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
ALTER TYPE "GithubEventType" ADD VALUE 'commit';

-- AlterTable
ALTER TABLE "GithubEvent" ADD COLUMN     "commitHash" TEXT,
ALTER COLUMN "pullRequestNumber" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "GithubRepo_owner_name_key" ON "GithubRepo"("owner", "name");
