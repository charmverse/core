-- CreateTable
CREATE TABLE "OptimismProjectAttestation" (
    "attestationId" TEXT NOT NULL,
    "farcasterIds" TEXT[],
    "name" TEXT NOT NULL,
    "metadataAttestationId" TEXT NOT NULL,
    "metadataUrl" TEXT NOT NULL,
    "metadata" JSONB NOT NULL,
    "timeCreated" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OptimismProjectAttestation_pkey" PRIMARY KEY ("attestationId")
);
