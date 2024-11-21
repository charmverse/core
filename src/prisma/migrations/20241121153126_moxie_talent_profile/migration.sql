-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "hasMoxieProfile" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "TalentProfile" (
    "id" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,
    "builderId" UUID NOT NULL,

    CONSTRAINT "TalentProfile_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TalentProfile_builderId_key" ON "TalentProfile"("builderId");

-- CreateIndex
CREATE INDEX "TalentProfile_builderId_idx" ON "TalentProfile"("builderId");

-- AddForeignKey
ALTER TABLE "TalentProfile" ADD CONSTRAINT "TalentProfile_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
