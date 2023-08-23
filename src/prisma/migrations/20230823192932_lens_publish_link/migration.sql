-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "lensPostLink" TEXT,
ADD COLUMN     "publishToLens" BOOLEAN;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "autoLensPublish" BOOLEAN DEFAULT false;
