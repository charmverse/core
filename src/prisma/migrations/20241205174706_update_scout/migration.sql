-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "deletedAt" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "ScoutMergeEvent" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mergedFromId" UUID NOT NULL,
    "mergedToId" UUID NOT NULL,
    "mergedRecords" JSONB NOT NULL
);

-- CreateIndex
CREATE INDEX "ScoutMergeEvent_mergedFromId_idx" ON "ScoutMergeEvent"("mergedFromId");

-- CreateIndex
CREATE INDEX "ScoutMergeEvent_mergedToId_idx" ON "ScoutMergeEvent"("mergedToId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutMergeEvent_mergedFromId_mergedToId_key" ON "ScoutMergeEvent"("mergedFromId", "mergedToId");

-- CreateIndex
CREATE INDEX "Scout_deletedAt_idx" ON "Scout"("deletedAt");

-- CreateIndex
CREATE INDEX "Scout_builderStatus_idx" ON "Scout"("builderStatus");

-- AddForeignKey
ALTER TABLE "ScoutMergeEvent" ADD CONSTRAINT "ScoutMergeEvent_mergedFromId_fkey" FOREIGN KEY ("mergedFromId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutMergeEvent" ADD CONSTRAINT "ScoutMergeEvent_mergedToId_fkey" FOREIGN KEY ("mergedToId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
