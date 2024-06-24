-- AlterTable
ALTER TABLE "Project" ADD COLUMN     "avatar" TEXT,
ADD COLUMN     "category" TEXT,
ADD COLUMN     "coverImage" TEXT,
ADD COLUMN     "farcasterIds" TEXT[] DEFAULT ARRAY[]::TEXT[],
ADD COLUMN     "mirror" TEXT,
ADD COLUMN     "websites" TEXT[] DEFAULT ARRAY[]::TEXT[];
