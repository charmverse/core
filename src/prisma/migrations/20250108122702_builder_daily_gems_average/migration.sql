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
