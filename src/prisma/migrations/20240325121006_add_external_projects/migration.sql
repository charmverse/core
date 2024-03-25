-- CreateEnum
CREATE TYPE "ExternalProjectSource" AS ENUM ('gitcoin', 'questbook');

-- AlterEnum
ALTER TYPE "AttestationType" ADD VALUE 'external';

-- CreateTable
CREATE TABLE "ExternalProject" (
    "id" UUID NOT NULL,
    "metadata" JSONB NOT NULL,
    "recipient" TEXT NOT NULL,
    "round" TEXT NOT NULL,
    "source" "ExternalProjectSource" NOT NULL,
    "schemaId" TEXT,
    "projectId" TEXT,
    "proposalUrl" TEXT,

    CONSTRAINT "ExternalProject_pkey" PRIMARY KEY ("id")
);
