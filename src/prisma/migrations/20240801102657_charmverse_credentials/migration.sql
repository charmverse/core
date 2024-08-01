-- CreateEnum
CREATE TYPE "QualifyingEventType" AS ENUM ('proposal_published', 'pull_request_merged');

-- CreateTable
CREATE TABLE "CharmUserCredential" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "chainId" INTEGER NOT NULL,
    "schemaId" TEXT NOT NULL,
    "attestationUID" TEXT NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "CharmUserCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharmProjectCredential" (
    "projectRefUID" TEXT NOT NULL,
    "farcasterIds" INTEGER[],
    "chainId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "metadataAttestationUID" TEXT NOT NULL,
    "metadataUrl" TEXT NOT NULL,
    "metadata" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "projectId" UUID,
    "userId" UUID NOT NULL,

    CONSTRAINT "CharmProjectCredential_pkey" PRIMARY KEY ("projectRefUID")
);

-- CreateTable
CREATE TABLE "CharmQualifyingEventCredential" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "qualifyingEventType" "QualifyingEventType" NOT NULL,
    "chainId" INTEGER NOT NULL,
    "schemaId" TEXT NOT NULL,
    "attestationUID" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "resourceUrl" TEXT,
    "proposalId" UUID,
    "projectId" UUID,

    CONSTRAINT "CharmQualifyingEventCredential_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CharmUserCredential" ADD CONSTRAINT "CharmUserCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmProjectCredential" ADD CONSTRAINT "CharmProjectCredential_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmProjectCredential" ADD CONSTRAINT "CharmProjectCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmQualifyingEventCredential" ADD CONSTRAINT "CharmQualifyingEventCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmQualifyingEventCredential" ADD CONSTRAINT "CharmQualifyingEventCredential_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmQualifyingEventCredential" ADD CONSTRAINT "CharmQualifyingEventCredential_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
