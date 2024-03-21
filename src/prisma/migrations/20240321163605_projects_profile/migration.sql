-- AlterEnum
ALTER TYPE "FormFieldType" ADD VALUE 'project_profile';

-- AlterTable
ALTER TABLE "FormField" ADD COLUMN     "fieldConfig" JSONB;

-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "projectId" UUID;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "claimed" BOOLEAN;

-- CreateTable
CREATE TABLE "ProjectMember" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "updatedBy" UUID NOT NULL,
    "teamLead" BOOLEAN NOT NULL DEFAULT false,
    "name" TEXT NOT NULL,
    "walletAddress" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "twitter" TEXT,
    "warpcast" TEXT,
    "github" TEXT,
    "linkedin" TEXT,
    "telegram" TEXT,
    "otherUrl" TEXT,
    "previousProjects" TEXT,
    "userId" UUID,
    "projectId" UUID NOT NULL,

    CONSTRAINT "ProjectMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedBy" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "excerpt" TEXT,
    "description" TEXT,
    "twitter" TEXT,
    "website" TEXT,
    "github" TEXT,
    "blog" TEXT,
    "productUrl" TEXT,
    "communityUrl" TEXT,
    "otherUrl" TEXT,
    "walletAddress" TEXT NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ProjectMember_userId_idx" ON "ProjectMember"("userId");

-- CreateIndex
CREATE INDEX "Project_createdBy_idx" ON "Project"("createdBy");

-- AddForeignKey
ALTER TABLE "Proposal" ADD CONSTRAINT "Proposal_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectMember" ADD CONSTRAINT "ProjectMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectMember" ADD CONSTRAINT "ProjectMember_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
