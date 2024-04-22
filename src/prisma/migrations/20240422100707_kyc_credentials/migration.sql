-- CreateEnum
CREATE TYPE "KycOption" AS ENUM ('persona', 'synaps');

-- CreateEnum
CREATE TYPE "SynapsUserKycStatus" AS ENUM ('APPROVED', 'REJECTED', 'RESUBMISSION_REQUIRED', 'SUBMISSION_REQUIRED', 'PENDING_VERIFICATION');

-- CreateEnum
CREATE TYPE "PersonaUserKycStatus" AS ENUM ('created', 'pending', 'completed', 'failed', 'expired', 'needs_review', 'approved', 'declined');

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "kycOption" "KycOption";

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
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),
    "sessionId" TEXT NOT NULL,
    "status" "SynapsUserKycStatus" NOT NULL,
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "SynapsUserKyc_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PersonaCredential" (
    "id" UUID NOT NULL,
    "apiKey" TEXT NOT NULL,
    "templateId" TEXT NOT NULL,
    "secret" TEXT,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PersonaCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PersonaUserKyc" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),
    "inquiryId" TEXT NOT NULL,
    "status" "PersonaUserKycStatus" NOT NULL,
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PersonaUserKyc_pkey" PRIMARY KEY ("id")
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

-- CreateIndex
CREATE UNIQUE INDEX "PersonaCredential_spaceId_key" ON "PersonaCredential"("spaceId");

-- CreateIndex
CREATE INDEX "PersonaCredential_spaceId_idx" ON "PersonaCredential"("spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "PersonaUserKyc_userId_key" ON "PersonaUserKyc"("userId");

-- CreateIndex
CREATE INDEX "PersonaUserKyc_userId_spaceId_idx" ON "PersonaUserKyc"("userId", "spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "PersonaUserKyc_userId_spaceId_key" ON "PersonaUserKyc"("userId", "spaceId");

-- AddForeignKey
ALTER TABLE "SynapsCredential" ADD CONSTRAINT "SynapsCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SynapsUserKyc" ADD CONSTRAINT "SynapsUserKyc_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SynapsUserKyc" ADD CONSTRAINT "SynapsUserKyc_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonaCredential" ADD CONSTRAINT "PersonaCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonaUserKyc" ADD CONSTRAINT "PersonaUserKyc_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonaUserKyc" ADD CONSTRAINT "PersonaUserKyc_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
