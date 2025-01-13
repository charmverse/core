-- AlterTable
ALTER TABLE "BuilderCardActivity" ADD COLUMN     "last14Days" JSONB NOT NULL DEFAULT '[]';
