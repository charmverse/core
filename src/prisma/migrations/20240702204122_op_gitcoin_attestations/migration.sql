-- CreateTable
CREATE TABLE "OptimismProjectAttestation" (
    "projectRefUID" TEXT NOT NULL,
    "farcasterIds" TEXT[],
    "name" TEXT NOT NULL,
    "metadataAttestationUID" TEXT NOT NULL,
    "metadataUrl" TEXT NOT NULL,
    "metadata" JSONB NOT NULL,
    "timeCreated" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OptimismProjectAttestation_pkey" PRIMARY KEY ("projectRefUID")
);

-- CreateTable
CREATE TABLE "GitcoinProjectAttestation" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "projectId" UUID NOT NULL,
    "chainId" INTEGER NOT NULL,
    "schemaId" TEXT NOT NULL,
    "attestationUID" TEXT NOT NULL,

    CONSTRAINT "GitcoinProjectAttestation_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "GitcoinProjectAttestation" ADD CONSTRAINT "GitcoinProjectAttestation_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
