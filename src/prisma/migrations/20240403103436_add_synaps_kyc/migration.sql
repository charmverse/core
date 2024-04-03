/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "SynapsUserKycStatus" AS ENUM ('APPROVED', 'REJECTED', 'RESUBMISSION_REQUIRED', 'SUBMISSION_REQUIRED', 'PENDING_VERIFICATION');

-- AlterTable
ALTER TABLE "Page" DROP COLUMN "pageId";

-- CreateTable
CREATE TABLE "SynapsCredential" (
    "id" UUID NOT NULL,
    "apiKey" TEXT NOT NULL,
    "secret" TEXT,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "SynapsCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SynapsUserKyc" (
    "id" UUID NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "sessionId" TEXT NOT NULL,
    "status" "SynapsUserKycStatus",
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "SynapsUserKyc_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "SynapsCredential_spaceId_key" ON "SynapsCredential"("spaceId");

-- CreateIndex
CREATE INDEX "SynapsCredential_spaceId_idx" ON "SynapsCredential"("spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "SynapsUserKyc_userId_key" ON "SynapsUserKyc"("userId");

-- CreateIndex
CREATE INDEX "SynapsUserKyc_userId_spaceId_idx" ON "SynapsUserKyc"("userId", "spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "SynapsUserKyc_userId_spaceId_key" ON "SynapsUserKyc"("userId", "spaceId");

-- AddForeignKey
ALTER TABLE "SynapsCredential" ADD CONSTRAINT "SynapsCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SynapsUserKyc" ADD CONSTRAINT "SynapsUserKyc_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SynapsUserKyc" ADD CONSTRAINT "SynapsUserKyc_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
