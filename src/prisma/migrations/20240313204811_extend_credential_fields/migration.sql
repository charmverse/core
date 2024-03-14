/*
  Warnings:

  - You are about to drop the column `issueCredentialsOnChainId` on the `Space` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[onchainAttestationId]` on the table `IssuedCredential` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "IssuedCredential" ADD COLUMN     "ceramicRecord" JSONB,
ADD COLUMN     "onchainAttestationId" TEXT,
ADD COLUMN     "onchainChainId" INTEGER,
ADD COLUMN     "schemaId" TEXT,
ALTER COLUMN "ceramicId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Space" DROP COLUMN "issueCredentialsOnChainId",
ADD COLUMN     "credentialsChainId" INTEGER;

-- CreateIndex
CREATE INDEX "CharmWallet_totalBalance_idx" ON "CharmWallet"("totalBalance" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "IssuedCredential_onchainAttestationId_key" ON "IssuedCredential"("onchainAttestationId");

-- CreateIndex
CREATE INDEX "User_createdAt_idx" ON "User"("createdAt" ASC);
