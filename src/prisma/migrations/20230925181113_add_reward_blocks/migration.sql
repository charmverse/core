-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "fields" JSONB;

-- CreateTable
CREATE TABLE "RewardBlock" (
    "id" TEXT NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedBy" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "parentId" TEXT NOT NULL,
    "rootId" UUID NOT NULL,
    "schema" INTEGER NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'board',
    "title" TEXT NOT NULL,
    "fields" JSONB NOT NULL,

    CONSTRAINT "RewardBlock_pkey" PRIMARY KEY ("id","spaceId")
);

-- CreateIndex
CREATE INDEX "RewardBlock_rootId_idx" ON "RewardBlock"("rootId");

-- CreateIndex
CREATE INDEX "RewardBlock_spaceId_idx" ON "RewardBlock"("spaceId");

-- CreateIndex
CREATE INDEX "RewardBlock_createdBy_idx" ON "RewardBlock"("createdBy");

-- AddForeignKey
ALTER TABLE "RewardBlock" ADD CONSTRAINT "RewardBlock_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RewardBlock" ADD CONSTRAINT "RewardBlock_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
