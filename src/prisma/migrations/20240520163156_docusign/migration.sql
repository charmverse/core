-- AlterEnum
ALTER TYPE "ProposalEvaluationType" ADD VALUE 'sign_documents';

-- CreateTable
CREATE TABLE "DocusignCredential" (
    "id" UUID NOT NULL,
    "docusignAccountId" TEXT NOT NULL,
    "docusignAccountName" TEXT NOT NULL,
    "docusignApiBaseUrl" TEXT NOT NULL,
    "docusignWebhookId" TEXT,
    "refreshToken" TEXT NOT NULL,
    "accessToken" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "webhookApiKey" TEXT,

    CONSTRAINT "DocusignCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentToSign" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "docusignEnvelopeId" TEXT NOT NULL,
    "evaluationId" UUID NOT NULL,
    "proposalId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "DocumentToSign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentSigner" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "documentToSignId" UUID NOT NULL,
    "completedAt" TIMESTAMP(3),
    "completedBy" UUID,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "DocumentSigner_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredential_docusignAccountId_key" ON "DocusignCredential"("docusignAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredential_spaceId_key" ON "DocusignCredential"("spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredential_webhookApiKey_key" ON "DocusignCredential"("webhookApiKey");

-- AddForeignKey
ALTER TABLE "DocusignCredential" ADD CONSTRAINT "DocusignCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocusignCredential" ADD CONSTRAINT "DocusignCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES "ProposalEvaluation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentSigner" ADD CONSTRAINT "DocumentSigner_documentToSignId_fkey" FOREIGN KEY ("documentToSignId") REFERENCES "DocumentToSign"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentSigner" ADD CONSTRAINT "DocumentSigner_completedBy_fkey" FOREIGN KEY ("completedBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
