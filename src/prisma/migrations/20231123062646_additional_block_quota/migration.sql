-- CreateTable
CREATE TABLE "AdditionalBlockQuota" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "blockCount" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdditionalBlockQuota_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "AdditionalBlockQuota" ADD CONSTRAINT "AdditionalBlockQuota_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
