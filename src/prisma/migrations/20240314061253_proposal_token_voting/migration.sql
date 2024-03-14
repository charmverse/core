-- CreateEnum
CREATE TYPE "VoteStrategy" AS ENUM ('regular', 'token', 'snapshot');

-- AlterTable
ALTER TABLE "UserVote" ADD COLUMN     "tokenAmount" TEXT;

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "blockNumber" TEXT,
ADD COLUMN     "chainId" INTEGER,
ADD COLUMN     "strategy" "VoteStrategy" NOT NULL DEFAULT 'regular',
ADD COLUMN     "tokenAddress" TEXT;

-- CreateIndex
CREATE INDEX "CharmWallet_totalBalance_idx" ON "CharmWallet"("totalBalance" DESC);

-- CreateIndex
CREATE INDEX "User_createdAt_idx" ON "User"("createdAt" ASC);
