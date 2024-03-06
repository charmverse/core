-- AlterTable
ALTER TABLE "UserVote" ADD COLUMN     "tokenAmount" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "blockNumber" INTEGER,
ADD COLUMN     "chainId" INTEGER,
ADD COLUMN     "tokenAddress" TEXT;
