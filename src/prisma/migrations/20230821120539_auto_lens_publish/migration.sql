-- DropIndex
DROP INDEX "User_xpsEngineId_key";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "autoLensPublish" BOOLEAN DEFAULT false;
