-- CreateEnum
CREATE TYPE "IssueCredentialEvent" AS ENUM ('proposal_created', 'proposal_approved');

-- CreateEnum
CREATE TYPE "CredentialType" AS ENUM ('proposal');

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "credentialTemplateId" UUID;

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "credentialEvents" "IssueCredentialEvent"[] DEFAULT ARRAY[]::"IssueCredentialEvent"[];

-- CreateTable
CREATE TABLE "CredentialTemplate" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "organization" TEXT NOT NULL,
    "description" TEXT DEFAULT '',
    "schemaType" "CredentialType" NOT NULL,
    "schemaAddress" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CredentialTemplate_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Proposal" ADD CONSTRAINT "Proposal_credentialTemplateId_fkey" FOREIGN KEY ("credentialTemplateId") REFERENCES "CredentialTemplate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CredentialTemplate" ADD CONSTRAINT "CredentialTemplate_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
