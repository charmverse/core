-- CreateTable
CREATE TABLE "AdditionalBlockQuota" (
    "spaceId" UUID NOT NULL,
    "expiration" TIMESTAMP(3) NOT NULL,
    "blockCount" INTEGER NOT NULL,

    CONSTRAINT "AdditionalBlockQuota_pkey" PRIMARY KEY ("spaceId")
);

-- AddForeignKey
ALTER TABLE "AdditionalBlockQuota" ADD CONSTRAINT "AdditionalBlockQuota_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
