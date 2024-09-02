-- CreateTable
CREATE TABLE "DataEcosystem" (
    "subEcosystems" TEXT[],
    "title" TEXT NOT NULL,
    "repos" TEXT[],
    "organizations" TEXT[]
);

-- CreateTable
CREATE TABLE "CryptoEcosystemRepo" (
    "githubId" INTEGER NOT NULL,
    "url" TEXT NOT NULL,
    "assignableUsers" INTEGER NOT NULL,
    "pullRequestAuthorsCount" INTEGER NOT NULL,
    "stargazerCount" INTEGER NOT NULL,
    "watcherCount" INTEGER NOT NULL,
    "forkCount" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "CryptoEcosystemAuthor" (
    "githubId" INTEGER NOT NULL,
    "login" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "twitter" TEXT
);

-- CreateTable
CREATE TABLE "CryptoEcosystemPullRequest" (
    "githubId" INTEGER NOT NULL,
    "repoGithubId" INTEGER NOT NULL,
    "userGithubId" INTEGER NOT NULL,
    "raw" JSONB NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "DataEcosystem_title_key" ON "DataEcosystem"("title");

-- CreateIndex
CREATE INDEX "DataEcosystem_title_idx" ON "DataEcosystem"("title");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemRepo_githubId_key" ON "CryptoEcosystemRepo"("githubId");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemAuthor_githubId_key" ON "CryptoEcosystemAuthor"("githubId");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemPullRequest_githubId_key" ON "CryptoEcosystemPullRequest"("githubId");
