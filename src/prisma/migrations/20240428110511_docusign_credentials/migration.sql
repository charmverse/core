-- CreateTable
CREATE TABLE "DocusignCredential" (
    "id" UUID NOT NULL,
    "docusignSccountId" TEXT NOT NULL,
    "docusignAccountName" TEXT NOT NULL,
    "refreshToken" TEXT NOT NULL,
    "accessToken" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "DocusignCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentToSign" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "docusignEnvelopeId" TEXT NOT NULL,
    "rewardId" UUID,

    CONSTRAINT "DocumentToSign_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "DocusignCredential_userId_spaceId_idx" ON "DocusignCredential"("userId", "spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredential_userId_spaceId_key" ON "DocusignCredential"("userId", "spaceId");

-- AddForeignKey
ALTER TABLE "DocusignCredential" ADD CONSTRAINT "DocusignCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocusignCredential" ADD CONSTRAINT "DocusignCredential_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
