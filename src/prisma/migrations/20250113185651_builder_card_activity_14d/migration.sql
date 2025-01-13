-- AlterTable
ALTER TABLE "BuilderCardActivity" ADD COLUMN     "last14Days" JSONB NOT NULL DEFAULT '[]',
ALTER COLUMN "last7Days" DROP NOT NULL;
