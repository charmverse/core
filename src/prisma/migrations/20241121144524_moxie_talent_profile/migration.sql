-- CreateTable
CREATE TABLE "TalentProfile" (
    "id" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "builderId" UUID NOT NULL,

    CONSTRAINT "TalentProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MoxieProfile" (
    "id" INTEGER NOT NULL,
    "builderId" UUID NOT NULL,

    CONSTRAINT "MoxieProfile_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TalentProfile_builderId_key" ON "TalentProfile"("builderId");

-- CreateIndex
CREATE INDEX "TalentProfile_builderId_idx" ON "TalentProfile"("builderId");

-- CreateIndex
CREATE UNIQUE INDEX "MoxieProfile_builderId_key" ON "MoxieProfile"("builderId");

-- CreateIndex
CREATE INDEX "MoxieProfile_builderId_idx" ON "MoxieProfile"("builderId");

-- AddForeignKey
ALTER TABLE "TalentProfile" ADD CONSTRAINT "TalentProfile_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MoxieProfile" ADD CONSTRAINT "MoxieProfile_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
