-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "githubIssueUrl" TEXT;

-- CreateTable
CREATE TABLE "SpaceGithubConnection" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "installationId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "SpaceGithubConnection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RewardsGithubRepo" (
    "id" UUID NOT NULL,
    "connectionId" UUID NOT NULL,
    "repositoryId" TEXT NOT NULL,
    "repositoryLabels" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "repositoryName" TEXT NOT NULL,
    "rewardAuthorId" UUID NOT NULL,
    "rewardTemplateId" UUID,

    CONSTRAINT "RewardsGithubRepo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "SpaceGithubConnection_spaceId_idx" ON "SpaceGithubConnection"("spaceId");

-- CreateIndex
CREATE INDEX "RewardsGithubRepo_connectionId_idx" ON "RewardsGithubRepo"("connectionId");

-- CreateIndex
CREATE UNIQUE INDEX "RewardsGithubRepo_connectionId_repositoryId_key" ON "RewardsGithubRepo"("connectionId", "repositoryId");

-- AddForeignKey
ALTER TABLE "SpaceGithubConnection" ADD CONSTRAINT "SpaceGithubConnection_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceGithubConnection" ADD CONSTRAINT "SpaceGithubConnection_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RewardsGithubRepo" ADD CONSTRAINT "RewardsGithubRepo_connectionId_fkey" FOREIGN KEY ("connectionId") REFERENCES "SpaceGithubConnection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RewardsGithubRepo" ADD CONSTRAINT "RewardsGithubRepo_rewardAuthorId_fkey" FOREIGN KEY ("rewardAuthorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RewardsGithubRepo" ADD CONSTRAINT "RewardsGithubRepo_rewardTemplateId_fkey" FOREIGN KEY ("rewardTemplateId") REFERENCES "Page"("id") ON DELETE CASCADE ON UPDATE CASCADE;
