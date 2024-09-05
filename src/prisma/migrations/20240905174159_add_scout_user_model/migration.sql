-- CreateTable
CREATE TABLE "Scout" (
    "id" UUID NOT NULL,
    "email" TEXT,
    "username" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "farcasterId" TEXT,
    "farcasterName" TEXT,
    "walletAddress" TEXT,
    "walletENS" TEXT,
    "avatar" TEXT,
    "bio" TEXT,
    "builder" BOOLEAN NOT NULL DEFAULT false,
    "sendMarketing" BOOLEAN NOT NULL DEFAULT false,
    "agreedToTOS" BOOLEAN NOT NULL DEFAULT false,
    "onboarded" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Scout_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Scout_username_key" ON "Scout"("username");

-- CreateIndex
CREATE INDEX "Scout_username_idx" ON "Scout"("username");
