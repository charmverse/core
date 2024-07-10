-- CreateEnum
CREATE TYPE "CharmCredentialType" AS ENUM ('user_identifier', 'qualifying_event');

-- CreateEnum
CREATE TYPE "QualifyingEventType" AS ENUM ('none', 'proposal_published', 'pull_request_merged');

-- CreateTable
CREATE TABLE "CharmCredential" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" "CharmCredentialType" NOT NULL,
    "qualifyingEventType" "QualifyingEventType" NOT NULL,
    "chainId" INTEGER NOT NULL,
    "schemaId" TEXT NOT NULL,
    "attestationUID" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "resourceUrl" TEXT,
    "proposalId" UUID,

    CONSTRAINT "CharmCredential_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CharmCredential" ADD CONSTRAINT "CharmCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmCredential" ADD CONSTRAINT "CharmCredential_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;
