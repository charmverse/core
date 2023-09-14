-- AlterTable
ALTER TABLE "Page" ADD COLUMN     "additionalPaths" TEXT[] DEFAULT ARRAY[]::TEXT[];
