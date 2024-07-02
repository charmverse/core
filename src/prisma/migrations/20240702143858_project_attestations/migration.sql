-- CreateTable
CREATE TABLE "OnchainProjectMeta" (
    "id" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "chainId" INTEGER NOT NULL,
    "schemaId" TEXT NOT NULL,
    "attestationId" TEXT NOT NULL,

    CONSTRAINT "OnchainProjectMeta_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "OnchainProjectMeta" ADD CONSTRAINT "OnchainProjectMeta_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
