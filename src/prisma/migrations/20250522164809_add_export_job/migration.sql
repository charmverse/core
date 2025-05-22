-- CreateEnum
CREATE TYPE "SpaceExportJobStatus" AS ENUM ('pending', 'completed', 'failed');

-- CreateTable
CREATE TABLE "SpaceExportJob" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "status" "SpaceExportJobStatus" NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "downloadLink" TEXT,
    "error" JSONB,

    CONSTRAINT "SpaceExportJob_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "SpaceExportJob_spaceId_status_idx" ON "SpaceExportJob"("spaceId", "status");

-- CreateIndex
CREATE INDEX "SpaceExportJob_createdBy_idx" ON "SpaceExportJob"("createdBy");

-- AddForeignKey
ALTER TABLE "SpaceExportJob" ADD CONSTRAINT "SpaceExportJob_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceExportJob" ADD CONSTRAINT "SpaceExportJob_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
