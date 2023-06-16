-- CreateTable
CREATE TABLE "BlockCount" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "count" INTEGER NOT NULL,
    "spaceId" UUID NOT NULL,
    "details" JSONB NOT NULL,

    CONSTRAINT "BlockCount_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "BlockCount_spaceId_idx" ON "BlockCount"("spaceId");

-- AddForeignKey
ALTER TABLE "BlockCount" ADD CONSTRAINT "BlockCount_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
