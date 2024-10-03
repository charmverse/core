-- CreateEnum
CREATE TYPE "GithubRepoOwnerType" AS ENUM ('user', 'org');

-- AlterTable
ALTER TABLE "GithubRepo" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "handPicked" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "ownerType" "GithubRepoOwnerType" NOT NULL DEFAULT 'org';

-- AlterTable
ALTER TABLE "GithubUser" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;
