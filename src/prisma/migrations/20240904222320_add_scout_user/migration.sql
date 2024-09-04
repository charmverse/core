-- CreateTable
CREATE TABLE "Scout" (
    "id" UUID NOT NULL,
    "email" TEXT,
    "username" TEXT,
    "farcasterId" TEXT,
    "walletAddress" TEXT,
    "walletENS" TEXT,
    "avatar" TEXT,
    "builder" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Scout_pkey" PRIMARY KEY ("id")
);
