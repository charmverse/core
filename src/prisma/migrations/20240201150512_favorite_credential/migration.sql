-- CreateTable
CREATE TABLE "FavoriteCredential" (
    "id" UUID NOT NULL,
    "index" INTEGER NOT NULL DEFAULT -1,
    "chainId" INTEGER,
    "userId" UUID NOT NULL,
    "attestationId" TEXT,
    "issuedCredentialId" UUID,
    "gitcoinWalletAddress" TEXT,

    CONSTRAINT "FavoriteCredential_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FavoriteCredential_issuedCredentialId_attestationId_gitcoin_key" ON "FavoriteCredential"("issuedCredentialId", "attestationId", "gitcoinWalletAddress");

-- AddForeignKey
ALTER TABLE "FavoriteCredential" ADD CONSTRAINT "FavoriteCredential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FavoriteCredential" ADD CONSTRAINT "FavoriteCredential_issuedCredentialId_fkey" FOREIGN KEY ("issuedCredentialId") REFERENCES "IssuedCredential"("id") ON DELETE SET NULL ON UPDATE CASCADE;
