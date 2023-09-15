-- AlterTable
ALTER TABLE "Page" ADD COLUMN     "additionalPaths" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- CreateIndex
CREATE INDEX "Page_path_idx" ON "Page"("path");

-- CreateIndex
CREATE INDEX "Page_additionalPaths_idx" ON "Page" USING GIN ("additionalPaths");
