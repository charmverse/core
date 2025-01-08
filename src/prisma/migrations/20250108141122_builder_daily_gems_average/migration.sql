/*
  Warnings:

  - Added the required column `last14Days` to the `BuilderCardActivity` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "BuilderCardActivity" ADD COLUMN     "last14Days" JSONB NOT NULL;

-- CreateTable
CREATE TABLE "BuilderDailyGemsAverage" (
    "id" UUID NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "week" TEXT NOT NULL,
    "gems" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "BuilderDailyGemsAverage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "BuilderDailyGemsAverage_date_key" ON "BuilderDailyGemsAverage"("date");
