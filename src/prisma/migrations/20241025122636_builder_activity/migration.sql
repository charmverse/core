-- CreateTable
CREATE TABLE "BuilderCardActivity" (
    "builderId" UUID NOT NULL,
    "last7Days" JSONB NOT NULL,

    CONSTRAINT "BuilderCardActivity_pkey" PRIMARY KEY ("builderId")
);

-- AddForeignKey
ALTER TABLE "BuilderCardActivity" ADD CONSTRAINT "BuilderCardActivity_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
