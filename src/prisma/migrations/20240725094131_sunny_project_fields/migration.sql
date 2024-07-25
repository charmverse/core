-- CreateEnum
CREATE TYPE "SunnyAwardsProjectType" AS ENUM ('creator', 'app', 'other');

-- AlterTable
ALTER TABLE "Project" ADD COLUMN     "mintingWalletAddress" TEXT,
ADD COLUMN     "primaryContractAddress" TEXT,
ADD COLUMN     "primaryContractChainId" INTEGER,
ADD COLUMN     "sunnyAwardsProjectType" "SunnyAwardsProjectType";
