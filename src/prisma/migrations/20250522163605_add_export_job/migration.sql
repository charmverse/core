-- CreateEnum
CREATE TYPE "SpaceExportJobStatus" AS ENUM ('pending', 'completed', 'failed');

-- CreateTable
CREATE TABLE "SpaceExportJob" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "spaceId" UUID NOT NULL,
    "status" "SpaceExportJobStatus" NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "downloadLink" TEXT,
    "error" JSONB,

    CONSTRAINT "SpaceExportJob_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SpaceExportJob" ADD CONSTRAINT "SpaceExportJob_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
