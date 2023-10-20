-- CreateIndex
CREATE INDEX "Application_spaceId_idx" ON "Application"("spaceId");

-- CreateIndex
CREATE INDEX "Block_type_idx" ON "Block"("type");

-- CreateIndex
CREATE INDEX "Page_spaceId_type_idx" ON "Page"("spaceId", "type");
