-- CreateEnum
CREATE TYPE "PullRequestStatus" AS ENUM ('open', 'closed', 'merged');

-- CreateTable
CREATE TABLE "PullRequestSummary" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "repoName" TEXT NOT NULL,
    "repoOwner" TEXT NOT NULL,
    "prTitle" TEXT NOT NULL,
    "prNumber" INTEGER NOT NULL,
    "createdBy" TEXT NOT NULL,
    "status" "PullRequestStatus" NOT NULL,
    "patches" JSONB NOT NULL,
    "additions" INTEGER NOT NULL,
    "deletions" INTEGER NOT NULL,
    "changedFiles" INTEGER NOT NULL,
    "model" TEXT NOT NULL,
    "prompt" TEXT NOT NULL,
    "promptTokens" INTEGER NOT NULL,
    "summary" TEXT NOT NULL,
    "summaryTokens" INTEGER NOT NULL,

    CONSTRAINT "PullRequestSummary_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PullRequestSummary_repoName_repoOwner_prNumber_model_prompt_key" ON "PullRequestSummary"("repoName", "repoOwner", "prNumber", "model", "prompt");
