-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "blockNumber" INTEGER;

-- AlterTable
ALTER TABLE "UserVote" ADD COLUMN     "tokenAmount" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "chainId" INTEGER,
ADD COLUMN     "tokenAddress" TEXT;
