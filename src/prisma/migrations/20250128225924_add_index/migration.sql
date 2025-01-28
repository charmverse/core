-- CreateIndex
CREATE INDEX "BuilderEvent_week_season_idx" ON "BuilderEvent"("week", "season");

-- CreateIndex
CREATE INDEX "BuilderEvent_createdAt_idx" ON "BuilderEvent"("createdAt");
