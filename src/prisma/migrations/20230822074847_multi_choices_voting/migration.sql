-- AlterTable
ALTER TABLE "UserVote" ADD COLUMN     "choices" TEXT[] DEFAULT ARRAY[]::TEXT[];
