-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'matchup_winner';

-- CreateTable
CREATE TABLE "ScoutMatchup" (
    "id" UUID NOT NULL,
    "week" TEXT NOT NULL,
    "totalScore" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "submittedAt" TIMESTAMP(3),
    "rank" INTEGER,

    CONSTRAINT "ScoutMatchup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutMatchupSelection" (
    "id" UUID NOT NULL,
    "matchUpId" UUID NOT NULL,
    "developerId" UUID NOT NULL,
    "gemsEarned" INTEGER NOT NULL DEFAULT 0,
    "creditsValue" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ScoutMatchupSelection_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutMatchup_createdBy_idx" ON "ScoutMatchup"("createdBy");

-- CreateIndex
CREATE INDEX "ScoutMatchup_week_submittedAt_idx" ON "ScoutMatchup"("week", "submittedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchup_createdBy_week_key" ON "ScoutMatchup"("createdBy", "week");

-- CreateIndex
CREATE INDEX "ScoutMatchupSelection_matchUpId_idx" ON "ScoutMatchupSelection"("matchUpId");

-- CreateIndex
CREATE INDEX "ScoutMatchupSelection_developerId_idx" ON "ScoutMatchupSelection"("developerId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMatchupSelection_matchUpId_developerId_key" ON "ScoutMatchupSelection"("matchUpId", "developerId");

-- AddForeignKey
ALTER TABLE "ScoutMatchup" ADD CONSTRAINT "ScoutMatchup_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutMatchupSelection" ADD CONSTRAINT "ScoutMatchupSelection_matchUpId_fkey" FOREIGN KEY ("matchUpId") REFERENCES "ScoutMatchup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutMatchupSelection" ADD CONSTRAINT "ScoutMatchupSelection_developerId_fkey" FOREIGN KEY ("developerId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
