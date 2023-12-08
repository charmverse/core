-- AlterTable
ALTER TABLE "Thread" ADD COLUMN     "accessGroups" JSONB[] DEFAULT ARRAY[]::JSONB[];
