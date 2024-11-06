-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'daily_claim';

-- AlterTable
ALTER TABLE "Scout" ALTER COLUMN "telegramId" SET DATA TYPE BIGINT;
