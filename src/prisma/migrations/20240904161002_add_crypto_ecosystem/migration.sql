-- CreateTable
CREATE TABLE "CryptoEcosystem" (
    "subEcosystems" TEXT[],
    "title" TEXT NOT NULL,
    "repoUrls" TEXT[],
    "organizations" TEXT[]
);

-- CreateTable
CREATE TABLE "CryptoEcosystemChild" (
    "parentTitle" TEXT NOT NULL,
    "childTitle" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CryptoEcosystemRepo" (
    "ecosystemTitle" TEXT NOT NULL,
    "githubId" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "assignableUsers" INTEGER NOT NULL,
    "pullRequestAuthorsCount" INTEGER NOT NULL,
    "stargazerCount" INTEGER NOT NULL,
    "watcherCount" INTEGER NOT NULL,
    "forkCount" INTEGER NOT NULL,
    "xtra" JSONB
);

-- CreateTable
CREATE TABLE "CryptoEcosystemAuthor" (
    "login" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "twitter" TEXT,
    "xtra" JSONB
);

-- CreateTable
CREATE TABLE "CryptoEcosystemPullRequest" (
    "date" TIMESTAMP(3) NOT NULL,
    "githubId" TEXT NOT NULL,
    "repoGithubId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "userGithubLogin" TEXT NOT NULL,
    "xtra" JSONB,
    "ecosystemTitle" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystem_title_key" ON "CryptoEcosystem"("title");

-- CreateIndex
CREATE INDEX "CryptoEcosystem_title_idx" ON "CryptoEcosystem"("title");

-- CreateIndex
CREATE INDEX "CryptoEcosystemChild_parentTitle_idx" ON "CryptoEcosystemChild"("parentTitle");

-- CreateIndex
CREATE INDEX "CryptoEcosystemChild_childTitle_idx" ON "CryptoEcosystemChild"("childTitle");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemChild_parentTitle_childTitle_key" ON "CryptoEcosystemChild"("parentTitle", "childTitle");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemRepo_githubId_key" ON "CryptoEcosystemRepo"("githubId");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemAuthor_login_key" ON "CryptoEcosystemAuthor"("login");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemPullRequest_githubId_key" ON "CryptoEcosystemPullRequest"("githubId");

-- AddForeignKey
ALTER TABLE "CryptoEcosystemChild" ADD CONSTRAINT "CryptoEcosystemChild_parentTitle_fkey" FOREIGN KEY ("parentTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemChild" ADD CONSTRAINT "CryptoEcosystemChild_childTitle_fkey" FOREIGN KEY ("childTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemRepo" ADD CONSTRAINT "CryptoEcosystemRepo_ecosystemTitle_fkey" FOREIGN KEY ("ecosystemTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_userGithubLogin_fkey" FOREIGN KEY ("userGithubLogin") REFERENCES "CryptoEcosystemAuthor"("login") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_repoGithubId_fkey" FOREIGN KEY ("repoGithubId") REFERENCES "CryptoEcosystemRepo"("githubId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemPullRequest" ADD CONSTRAINT "CryptoEcosystemPullRequest_ecosystemTitle_fkey" FOREIGN KEY ("ecosystemTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;
