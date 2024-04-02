/*
  Warnings:

  - You are about to drop the column `pageId` on the `Page` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "ComplianceVendor" AS ENUM ('synaps');

-- AlterTable
ALTER TABLE "Page" DROP COLUMN "pageId";

-- CreateTable
CREATE TABLE "Compliance" (
    "id" UUID NOT NULL,
    "apiKey" TEXT NOT NULL,
    "secret" TEXT,
    "spaceId" UUID NOT NULL,
    "type" "ComplianceVendor" NOT NULL,

    CONSTRAINT "Compliance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCompliance" (
    "id" UUID NOT NULL,
    "status" TEXT NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "UserCompliance_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Compliance_spaceId_key" ON "Compliance"("spaceId");

-- CreateIndex
CREATE INDEX "Compliance_spaceId_idx" ON "Compliance"("spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "UserCompliance_userId_key" ON "UserCompliance"("userId");

-- CreateIndex
CREATE INDEX "UserCompliance_userId_idx" ON "UserCompliance"("userId");

-- AddForeignKey
ALTER TABLE "Compliance" ADD CONSTRAINT "Compliance_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCompliance" ADD CONSTRAINT "UserCompliance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
