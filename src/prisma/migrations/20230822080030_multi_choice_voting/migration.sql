-- AlterTable
ALTER TABLE "UserVote" ADD COLUMN     "choices" TEXT[] DEFAULT ARRAY[]::TEXT[],
ALTER COLUMN "choice" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Vote" ADD COLUMN     "maxChoices" INTEGER DEFAULT 1;
