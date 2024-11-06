-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'daily_claim';

-- CreateTable
CREATE TABLE "ScoutQuest" (
    "userId" UUID NOT NULL,
    "completedQuests" JSONB[],

    CONSTRAINT "ScoutQuest_pkey" PRIMARY KEY ("userId")
);

-- CreateIndex
CREATE UNIQUE INDEX "ScoutQuest_userId_key" ON "ScoutQuest"("userId");

-- AddForeignKey
ALTER TABLE "ScoutQuest" ADD CONSTRAINT "ScoutQuest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
