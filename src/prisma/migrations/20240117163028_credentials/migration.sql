-- CreateEnum
CREATE TYPE "CredentialEventType" AS ENUM ('proposal_created', 'proposal_approved');

-- CreateEnum
CREATE TYPE "CredentialType" AS ENUM ('proposal');

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "selectedCredentialTemplates" TEXT[];

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "credentialEvents" "CredentialEventType"[] DEFAULT ARRAY[]::"CredentialEventType"[];

-- CreateTable
CREATE TABLE "CredentialTemplate" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "organization" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "schemaType" "CredentialType" NOT NULL,
    "schemaAddress" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CredentialTemplate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IssuedCredential" (
    "id" UUID NOT NULL,
    "credentialTemplateId" UUID,
    "proposalId" UUID NOT NULL,
    "ceramicId" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "credentialEvent" "CredentialEventType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "IssuedCredential_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CredentialTemplate" ADD CONSTRAINT "CredentialTemplate_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IssuedCredential" ADD CONSTRAINT "IssuedCredential_credentialTemplateId_fkey" FOREIGN KEY ("credentialTemplateId") REFERENCES "CredentialTemplate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IssuedCredential" ADD CONSTRAINT "IssuedCredential_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IssuedCredential" ADD CONSTRAINT "IssuedCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
