-- CreateEnum
CREATE TYPE "OnchainAchievementTier" AS ENUM ('bronze', 'silver', 'gold');

-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'onchain_achievement';

-- AlterEnum
ALTER TYPE "GemsReceiptType" ADD VALUE 'onchain_achievement';

-- AlterTable
ALTER TABLE "BuilderEvent" ADD COLUMN     "onchainActivityEventId" UUID;

-- CreateTable
CREATE TABLE "ScoutProjectOnchainAchievement" (
    "id" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tier" "OnchainAchievementTier" NOT NULL,
    "week" TEXT NOT NULL,

    CONSTRAINT "ScoutProjectOnchainAchievement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutProjectOnchainAchievement_projectId_idx" ON "ScoutProjectOnchainAchievement"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectOnchainAchievement_week_idx" ON "ScoutProjectOnchainAchievement"("week");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectOnchainAchievement_projectId_week_tier_key" ON "ScoutProjectOnchainAchievement"("projectId", "week", "tier");

-- AddForeignKey
ALTER TABLE "BuilderEvent" ADD CONSTRAINT "BuilderEvent_onchainActivityEventId_fkey" FOREIGN KEY ("onchainActivityEventId") REFERENCES "ScoutProjectOnchainAchievement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectOnchainAchievement" ADD CONSTRAINT "ScoutProjectOnchainAchievement_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE CASCADE ON UPDATE CASCADE;
