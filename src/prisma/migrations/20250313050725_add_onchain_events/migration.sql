-- CreateEnum
CREATE TYPE "OnchainActivityTier" AS ENUM ('bronze', 'silver', 'gold');

-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'onchain_activity';

-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "onchainActivityEventId" UUID;

-- CreateTable
CREATE TABLE "ScoutProjectOnchainActivityEvent" (
    "id" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tier" "OnchainActivityTier" NOT NULL,
    "week" TEXT NOT NULL,

    CONSTRAINT "ScoutProjectOnchainActivityEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutProjectOnchainActivityEvent_projectId_idx" ON "ScoutProjectOnchainActivityEvent"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectOnchainActivityEvent_week_idx" ON "ScoutProjectOnchainActivityEvent"("week");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectOnchainActivityEvent_projectId_week_tier_key" ON "ScoutProjectOnchainActivityEvent"("projectId", "week", "tier");

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_onchainActivityEventId_fkey" FOREIGN KEY ("onchainActivityEventId") REFERENCES "ScoutProjectOnchainActivityEvent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectOnchainActivityEvent" ADD CONSTRAINT "ScoutProjectOnchainActivityEvent_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE CASCADE ON UPDATE CASCADE;
