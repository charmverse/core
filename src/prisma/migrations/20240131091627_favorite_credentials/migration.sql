-- CreateTable
CREATE TABLE "FavoriteCredential" (
    "id" UUID NOT NULL,
    "index" INTEGER NOT NULL DEFAULT -1,
    "attestationId" UUID,
    "chainId" INTEGER,
    "issuedCredentialId" UUID,

    CONSTRAINT "FavoriteCredential_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "FavoriteCredential" ADD CONSTRAINT "FavoriteCredential_issuedCredentialId_fkey" FOREIGN KEY ("issuedCredentialId") REFERENCES "IssuedCredential"("id") ON DELETE SET NULL ON UPDATE CASCADE;
