-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "bannedAt" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "BuilderStrike" (
    "id" UUID NOT NULL,
    "builderId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BuilderStrike_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "BuilderStrike" ADD CONSTRAINT "BuilderStrike_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
