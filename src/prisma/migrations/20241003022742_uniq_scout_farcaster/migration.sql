/*
  Warnings:

  - A unique constraint covering the columns `[farcasterId]` on the table `Scout` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Scout_farcasterId_key" ON "Scout"("farcasterId");
