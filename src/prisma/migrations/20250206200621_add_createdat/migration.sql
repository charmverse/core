/*
  Warnings:

  - Added the required column `createdAt` to the `ScoutProjectContractTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ScoutProjectContractTransaction" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE INDEX "ScoutProjectContractTransaction_createdAt_idx" ON "ScoutProjectContractTransaction"("createdAt");
