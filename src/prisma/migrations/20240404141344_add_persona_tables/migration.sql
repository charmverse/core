-- CreateEnum
CREATE TYPE "PersonaUserKycStatus" AS ENUM ('created', 'pending', 'completed', 'failed', 'expired', 'needs_review', 'approved', 'declined');

-- CreateTable
CREATE TABLE "PersonaCredential" (
    "id" UUID NOT NULL,
    "apiKey" TEXT NOT NULL,
    "envId" TEXT NOT NULL,
    "templateId" TEXT[],
    "secret" TEXT,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PersonaCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PersonaUserKyc" (
    "id" UUID NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "inquiryId" TEXT NOT NULL,
    "status" "PersonaUserKycStatus",
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PersonaUserKyc_pkey" PRIMARY KEY ("id")
);

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
ALTER TABLE "PersonaCredential" ADD CONSTRAINT "PersonaCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonaUserKyc" ADD CONSTRAINT "PersonaUserKyc_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonaUserKyc" ADD CONSTRAINT "PersonaUserKyc_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
