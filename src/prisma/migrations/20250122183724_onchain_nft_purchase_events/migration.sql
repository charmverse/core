/*
  Warnings:

  - You are about to drop the column `scoutId` on the `NFTPurchaseEvent` table. All the data in the column will be lost.
  - Made the column `txLogIndex` on table `NFTPurchaseEvent` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "NFTPurchaseEvent" DROP CONSTRAINT "NFTPurchaseEvent_scoutId_fkey";

-- DropIndex
DROP INDEX "NFTPurchaseEvent_scoutId_idx";

-- AlterTable
ALTER TABLE "NFTPurchaseEvent" DROP COLUMN "scoutId",
ALTER COLUMN "txLogIndex" SET NOT NULL;
