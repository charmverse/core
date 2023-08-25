-- CreateEnum
CREATE TYPE "ProposalBlockType" AS ENUM ('properties', 'view');

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "properties" JSONB;

-- CreateTable
CREATE TABLE "ProposalBlock" (
    "id" UUID NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedBy" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "parentId" TEXT NOT NULL,
    "rootId" UUID NOT NULL,
    "schema" INTEGER NOT NULL,
    "type" "ProposalBlockType" NOT NULL,
    "title" TEXT NOT NULL,
    "fields" JSONB NOT NULL,

    CONSTRAINT "ProposalBlock_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProposalBlock_rootId_idx" ON "ProposalBlock"("rootId");

-- CreateIndex
CREATE INDEX "ProposalBlock_spaceId_idx" ON "ProposalBlock"("spaceId");

-- CreateIndex
CREATE INDEX "ProposalBlock_createdBy_idx" ON "ProposalBlock"("createdBy");

-- AddForeignKey
ALTER TABLE "ProposalBlock" ADD CONSTRAINT "ProposalBlock_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProposalBlock" ADD CONSTRAINT "ProposalBlock_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
