/*
  Warnings:

  - You are about to drop the `DataEcosystem` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `ecosystemTitle` to the `CryptoEcosystemPullRequest` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ecosystemTitle` to the `CryptoEcosystemRepo` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CryptoEcosystemPullRequest" ADD COLUMN     "ecosystemTitle" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "CryptoEcosystemRepo" ADD COLUMN     "ecosystemTitle" TEXT NOT NULL;

-- DropTable
DROP TABLE "DataEcosystem";

-- CreateTable
CREATE TABLE "CryptoEcosystem" (
    "subEcosystems" TEXT[],
    "title" TEXT NOT NULL,
    "repoUrls" TEXT[],
    "organizations" TEXT[]
);

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystem_title_key" ON "CryptoEcosystem"("title");

-- CreateIndex
CREATE INDEX "CryptoEcosystem_title_idx" ON "CryptoEcosystem"("title");

-- AddForeignKey
ALTER TABLE "CryptoEcosystemRepo" ADD CONSTRAINT "CryptoEcosystemRepo_ecosystemTitle_fkey" FOREIGN KEY ("ecosystemTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_userGithubId_fkey" FOREIGN KEY ("userGithubId") REFERENCES "CryptoEcosystemAuthor"("githubId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_repoGithubId_fkey" FOREIGN KEY ("repoGithubId") REFERENCES "CryptoEcosystemRepo"("githubId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_ecosystemTitle_fkey" FOREIGN KEY ("ecosystemTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;
