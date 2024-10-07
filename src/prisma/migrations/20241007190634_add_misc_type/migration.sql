-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'misc_event';

-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "description" TEXT;
