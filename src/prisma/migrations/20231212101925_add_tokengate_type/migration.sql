-- CreateEnum
CREATE TYPE "TokenGateType" AS ENUM ('lit', 'unlock');

-- AlterTable
ALTER TABLE "TokenGate" ADD COLUMN     "type" "TokenGateType" NOT NULL DEFAULT 'lit';
