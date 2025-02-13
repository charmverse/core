-- CreateEnum
CREATE TYPE "ScoutProjectContractType" AS ENUM ('contract', 'wallet');

-- AlterTable
ALTER TABLE "ScoutProjectContract" ADD COLUMN     "type" "ScoutProjectContractType" NOT NULL DEFAULT 'contract',
ALTER COLUMN "deployedAt" DROP NOT NULL;

-- CreateIndex
CREATE INDEX "ScoutProjectContract_type_idx" ON "ScoutProjectContract"("type");
