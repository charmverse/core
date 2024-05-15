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
    "spaceDocusignApiKey" TEXT,

    CONSTRAINT "DocusignCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentToSign" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "docusignEnvelopeId" TEXT NOT NULL,
    "rewardId" UUID,
    "proposalId" UUID,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "DocumentToSign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentSigner" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "documentToSignId" UUID NOT NULL,
    "completedAt" TIMESTAMP(3),
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "DocumentSigner_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredential_spaceDocusignApiKey_key" ON "DocusignCredential"("spaceDocusignApiKey");

-- CreateIndex
CREATE INDEX "DocusignCredential_userId_spaceId_idx" ON "DocusignCredential"("userId", "spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredential_userId_spaceId_key" ON "DocusignCredential"("userId", "spaceId");

-- AddForeignKey
ALTER TABLE "DocusignCredential" ADD CONSTRAINT "DocusignCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocusignCredential" ADD CONSTRAINT "DocusignCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_rewardId_fkey" FOREIGN KEY ("rewardId") REFERENCES "Bounty"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentToSign" ADD CONSTRAINT "DocumentToSign_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentSigner" ADD CONSTRAINT "DocumentSigner_documentToSignId_fkey" FOREIGN KEY ("documentToSignId") REFERENCES "DocumentToSign"("id") ON DELETE CASCADE ON UPDATE CASCADE;
