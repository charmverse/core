-- CreateEnum
CREATE TYPE "ScoutProjectMemberRole" AS ENUM ('owner', 'member');

-- CreateTable
CREATE TABLE "ScoutProject" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "avatar" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "website" TEXT NOT NULL,
    "github" TEXT NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "ScoutProject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutProjectMember" (
    "projectId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "role" "ScoutProjectMemberRole" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" UUID NOT NULL,
    "deletedAt" TIMESTAMP(3)
);

-- CreateTable
CREATE TABLE "ScoutProjectContract" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "deployedAt" TIMESTAMP(3) NOT NULL,
    "projectId" UUID NOT NULL,
    "address" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "deployerId" UUID NOT NULL,
    "deployTxHash" TEXT NOT NULL,
    "blockNumber" INTEGER NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "ScoutProjectContract_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutProjectDeployer" (
    "id" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "address" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "verifiedAt" TIMESTAMP(3),
    "verifiedBy" UUID,

    CONSTRAINT "ScoutProjectDeployer_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutProject_deletedAt_idx" ON "ScoutProject"("deletedAt");

-- CreateIndex
CREATE INDEX "ScoutProjectMember_projectId_idx" ON "ScoutProjectMember"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectMember_userId_idx" ON "ScoutProjectMember"("userId");

-- CreateIndex
CREATE INDEX "ScoutProjectMember_deletedAt_idx" ON "ScoutProjectMember"("deletedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectMember_projectId_userId_key" ON "ScoutProjectMember"("projectId", "userId");

-- CreateIndex
CREATE INDEX "ScoutProjectContract_projectId_idx" ON "ScoutProjectContract"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectContract_address_idx" ON "ScoutProjectContract"("address");

-- CreateIndex
CREATE INDEX "ScoutProjectContract_deletedAt_idx" ON "ScoutProjectContract"("deletedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectContract_address_chainId_key" ON "ScoutProjectContract"("address", "chainId");

-- CreateIndex
CREATE INDEX "ScoutProjectDeployer_projectId_idx" ON "ScoutProjectDeployer"("projectId");

-- CreateIndex
CREATE INDEX "ScoutProjectDeployer_address_idx" ON "ScoutProjectDeployer"("address");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutProjectDeployer_projectId_address_key" ON "ScoutProjectDeployer"("projectId", "address");

-- AddForeignKey
ALTER TABLE "ScoutProjectMember" ADD CONSTRAINT "ScoutProjectMember_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectMember" ADD CONSTRAINT "ScoutProjectMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectContract" ADD CONSTRAINT "ScoutProjectContract_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectContract" ADD CONSTRAINT "ScoutProjectContract_deployerId_fkey" FOREIGN KEY ("deployerId") REFERENCES "ScoutProjectDeployer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutProjectDeployer" ADD CONSTRAINT "ScoutProjectDeployer_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "ScoutProject"("id") ON DELETE CASCADE ON UPDATE CASCADE;
