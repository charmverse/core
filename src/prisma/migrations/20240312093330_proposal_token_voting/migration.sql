-- CreateEnum
CREATE TYPE "VoteStrategy" AS ENUM ('regular', 'token', 'snapshot');

-- AlterTable
ALTER TABLE "UserVote" ADD COLUMN     "tokenAmount" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "blockNumber" TEXT,
ADD COLUMN     "chainId" INTEGER,
ADD COLUMN     "strategy" "VoteStrategy" NOT NULL DEFAULT 'regular',
ADD COLUMN     "tokenAddress" TEXT;
