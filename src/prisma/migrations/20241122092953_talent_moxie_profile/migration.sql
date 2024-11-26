-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "hasMoxieProfile" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "TalentProfile" (
    "id" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,
    "builderId" UUID NOT NULL,
    "address" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TalentProfile_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TalentProfile_builderId_key" ON "TalentProfile"("builderId");

-- CreateIndex
CREATE UNIQUE INDEX "TalentProfile_address_key" ON "TalentProfile"("address");

-- CreateIndex
CREATE INDEX "TalentProfile_builderId_idx" ON "TalentProfile"("builderId");

-- AddForeignKey
ALTER TABLE "TalentProfile" ADD CONSTRAINT "TalentProfile_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
