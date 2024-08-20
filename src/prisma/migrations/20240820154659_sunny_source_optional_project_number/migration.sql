-- AlterEnum
ALTER TYPE "ProjectSource" ADD VALUE 'sunny_awards';

-- AlterTable
ALTER TABLE "Project" ALTER COLUMN "sunnyAwardsNumber" DROP NOT NULL,
ALTER COLUMN "sunnyAwardsNumber" DROP DEFAULT;
DROP SEQUENCE "Project_sunnyAwardsNumber_seq";
