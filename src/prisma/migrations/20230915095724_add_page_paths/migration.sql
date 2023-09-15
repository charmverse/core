-- AlterTable
ALTER TABLE "Page" ADD COLUMN     "additionalPaths" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- CreateIndex
CREATE INDEX "Page_path_idx" ON "Page"("path");

-- CreateIndex
CREATE INDEX "Page_spaceId_additionalPaths_idx" ON "Page"("spaceId", "additionalPaths");
