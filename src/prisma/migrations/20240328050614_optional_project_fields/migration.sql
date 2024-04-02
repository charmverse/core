-- AlterTable
ALTER TABLE "Project" ALTER COLUMN "walletAddress" DROP NOT NULL;

-- AlterTable
ALTER TABLE "ProjectMember" ALTER COLUMN "walletAddress" DROP NOT NULL,
ALTER COLUMN "email" DROP NOT NULL;
