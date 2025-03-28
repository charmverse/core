-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'matchup_winner';

-- CreateTable
CREATE TABLE "ScoutMatchUp" (
    "id" UUID NOT NULL,
    "scoutId" UUID NOT NULL,
    "week" TEXT NOT NULL,
    "totalScore" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rank" INTEGER,

    CONSTRAINT "ScoutMatchUp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutMatchUpSelection" (
    "id" UUID NOT NULL,
    "matchUpId" UUID NOT NULL,
    "developerId" UUID NOT NULL,
    "gemsEarned" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ScoutMatchUpSelection_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutMatchUp_scoutId_idx" ON "ScoutMatchUp"("scoutId");

-- CreateIndex
CREATE INDEX "ScoutMatchUp_week_idx" ON "ScoutMatchUp"("week");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchUp_scoutId_week_key" ON "ScoutMatchUp"("scoutId", "week");

-- CreateIndex
CREATE INDEX "ScoutMatchUpSelection_matchUpId_idx" ON "ScoutMatchUpSelection"("matchUpId");

-- CreateIndex
CREATE INDEX "ScoutMatchUpSelection_developerId_idx" ON "ScoutMatchUpSelection"("developerId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchUpSelection_matchUpId_developerId_key" ON "ScoutMatchUpSelection"("matchUpId", "developerId");

-- AddForeignKey
ALTER TABLE "ScoutMatchUp" ADD CONSTRAINT "ScoutMatchUp_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutMatchUpSelection" ADD CONSTRAINT "ScoutMatchUpSelection_matchUpId_fkey" FOREIGN KEY ("matchUpId") REFERENCES "ScoutMatchUp"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutMatchUpSelection" ADD CONSTRAINT "ScoutMatchUpSelection_developerId_fkey" FOREIGN KEY ("developerId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
