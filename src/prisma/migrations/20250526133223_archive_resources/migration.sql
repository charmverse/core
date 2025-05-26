-- AlterTable
ALTER TABLE "ProposalWorkflow" ADD COLUMN     "archived" BOOLEAN DEFAULT false;

-- AlterTable
ALTER TABLE "Role" ADD COLUMN     "archived" BOOLEAN DEFAULT false;

-- AlterTable
ALTER TABLE "TokenGate" ADD COLUMN     "archived" BOOLEAN;
