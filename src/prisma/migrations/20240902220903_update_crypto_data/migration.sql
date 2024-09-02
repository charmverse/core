/*
  Warnings:

  - You are about to drop the column `githubId` on the `CryptoEcosystemAuthor` table. All the data in the column will be lost.
  - You are about to drop the column `userGithubId` on the `CryptoEcosystemPullRequest` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[login]` on the table `CryptoEcosystemAuthor` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `userGithubLogin` to the `CryptoEcosystemPullRequest` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" DROP CONSTRAINT "CryptoEcosystemPullRequest_repoGithubId_fkey";

-- DropForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" DROP CONSTRAINT "CryptoEcosystemPullRequest_userGithubId_fkey";

-- DropIndex
DROP INDEX "CryptoEcosystemAuthor_githubId_key";

-- AlterTable
ALTER TABLE "CryptoEcosystemAuthor" DROP COLUMN "githubId";

-- AlterTable
ALTER TABLE "CryptoEcosystemPullRequest" DROP COLUMN "userGithubId",
ADD COLUMN     "userGithubLogin" TEXT NOT NULL,
ALTER COLUMN "repoGithubId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "CryptoEcosystemRepo" ALTER COLUMN "githubId" SET DATA TYPE TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemAuthor_login_key" ON "CryptoEcosystemAuthor"("login");

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_userGithubLogin_fkey" FOREIGN KEY ("userGithubLogin") REFERENCES "CryptoEcosystemAuthor"("login") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_repoGithubId_fkey" FOREIGN KEY ("repoGithubId") REFERENCES "CryptoEcosystemRepo"("githubId") ON DELETE CASCADE ON UPDATE CASCADE;
