-- CreateEnum
CREATE TYPE "FarcasterCastAction" AS ENUM ('like_created', 'like_removed', 'recast_created', 'recast_removed', 'cast_created');

-- CreateTable
CREATE TABLE "FarcasterCast" (
    "id" UUID NOT NULL,
    "hash" TEXT NOT NULL,
    "totalLikes" INTEGER NOT NULL DEFAULT 0,
    "totalComments" INTEGER NOT NULL DEFAULT 0,
    "totalRecasts" INTEGER NOT NULL DEFAULT 0,
    "text" TEXT NOT NULL,
    "channel" TEXT,
    "embeds" JSONB[],
    "authorFid" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "action" "FarcasterCastAction" NOT NULL,

    CONSTRAINT "FarcasterCast_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FarcasterCast_hash_key" ON "FarcasterCast"("hash");
