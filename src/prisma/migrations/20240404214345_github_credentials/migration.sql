/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Page" DROP COLUMN "pageId";

-- CreateTable
CREATE TABLE "SpaceGithubCredential" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" UUID NOT NULL,
    "error" JSONB,
    "name" TEXT NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "SpaceGithubCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RewardsGithubRepo" (
    "id" TEXT NOT NULL,
    "credentialId" UUID NOT NULL,
    "settings" JSONB NOT NULL DEFAULT '{}',
    "rewardTemplateId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "RewardsGithubRepo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "SpaceGithubCredential_spaceId_idx" ON "SpaceGithubCredential"("spaceId");

-- CreateIndex
CREATE INDEX "RewardsGithubRepo_credentialId_idx" ON "RewardsGithubRepo"("credentialId");

-- AddForeignKey
ALTER TABLE "SpaceGithubCredential" ADD CONSTRAINT "SpaceGithubCredential_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceGithubCredential" ADD CONSTRAINT "SpaceGithubCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RewardsGithubRepo" ADD CONSTRAINT "RewardsGithubRepo_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "SpaceGithubCredential"("id") ON DELETE CASCADE ON UPDATE CASCADE;
