-- AlterTable
ALTER TABLE "PageComment" ADD COLUMN     "lensCommentLink" TEXT;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "publishToLensDefault" SET DEFAULT true;
