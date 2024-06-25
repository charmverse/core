-- CreateEnum
CREATE TYPE "ProjectSource" AS ENUM ('charmverse', 'connect');

-- AlterTable
ALTER TABLE "Project" ADD COLUMN     "avatar" TEXT,
ADD COLUMN     "category" TEXT,
ADD COLUMN     "coverImage" TEXT,
ADD COLUMN     "farcasterIds" TEXT[] DEFAULT ARRAY[]::TEXT[],
ADD COLUMN     "mirror" TEXT,
ADD COLUMN     "source" "ProjectSource" NOT NULL DEFAULT 'charmverse',
ADD COLUMN     "websites" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "ProjectMember" ADD COLUMN     "farcasterId" INTEGER;
