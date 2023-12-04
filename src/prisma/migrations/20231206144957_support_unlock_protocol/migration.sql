-- AlterTable
ALTER TABLE "TokenGate" ADD COLUMN     "lock" JSONB,
ALTER COLUMN "conditions" DROP NOT NULL;
