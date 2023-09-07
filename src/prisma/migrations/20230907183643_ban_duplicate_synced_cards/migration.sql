/*
  Warnings:

  - A unique constraint covering the columns `[parentId,syncWithPageId]` on the table `Page` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Page_parentId_syncWithPageId_key" ON "Page"("parentId", "syncWithPageId");
