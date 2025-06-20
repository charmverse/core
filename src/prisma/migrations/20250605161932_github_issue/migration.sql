-- CreateTable
CREATE TABLE "GithubIssue" (
    "pullRequestNumber" INTEGER NOT NULL,
    "githubEventId" UUID NOT NULL,
    "repoId" INTEGER NOT NULL,
    "issueNumber" INTEGER NOT NULL,
    "tags" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE INDEX "GithubIssue_repoId_idx" ON "GithubIssue"("repoId");

-- CreateIndex
CREATE INDEX "GithubIssue_githubEventId_idx" ON "GithubIssue"("githubEventId");

-- CreateIndex
CREATE UNIQUE INDEX "GithubIssue_issueNumber_repoId_key" ON "GithubIssue"("issueNumber", "repoId");

-- AddForeignKey
ALTER TABLE "GithubIssue" ADD CONSTRAINT "GithubIssue_githubEventId_fkey" FOREIGN KEY ("githubEventId") REFERENCES "GithubEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GithubIssue" ADD CONSTRAINT "GithubIssue_repoId_fkey" FOREIGN KEY ("repoId") REFERENCES "GithubRepo"("id") ON DELETE CASCADE ON UPDATE CASCADE;
