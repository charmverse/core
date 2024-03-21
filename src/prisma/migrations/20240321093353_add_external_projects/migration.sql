-- AlterEnum
ALTER TYPE "AttestationType" ADD VALUE 'external';

-- CreateTable
CREATE TABLE "ExternalProjects" (
    "id" UUID NOT NULL,
    "metadata" JSONB NOT NULL,
    "recipient" TEXT NOT NULL,
    "schemaId" TEXT,
    "ceramicId" TEXT,
    "source" TEXT NOT NULL,

    CONSTRAINT "ExternalProjects_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ExternalProjects_ceramicId_key" ON "ExternalProjects"("ceramicId");
