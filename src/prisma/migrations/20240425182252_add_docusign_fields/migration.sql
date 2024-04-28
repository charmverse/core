-- CreateTable
CREATE TABLE "DocusignCredentials" (
    "id" UUID NOT NULL,
    "accountId" TEXT NOT NULL,
    "refreshToken" TEXT NOT NULL,
    "accessToken" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "DocusignCredentials_pkey" PRIMARY KEY ("id")
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
CREATE INDEX "DocusignCredentials_userId_spaceId_idx" ON "DocusignCredentials"("userId", "spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "DocusignCredentials_userId_spaceId_key" ON "DocusignCredentials"("userId", "spaceId");

-- AddForeignKey
ALTER TABLE "DocusignCredentials" ADD CONSTRAINT "DocusignCredentials_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocusignCredentials" ADD CONSTRAINT "DocusignCredentials_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
