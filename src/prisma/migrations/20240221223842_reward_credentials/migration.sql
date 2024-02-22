-- AlterEnum
ALTER TYPE "AttestationType" ADD VALUE 'reward';

-- AlterEnum
ALTER TYPE "CredentialEventType" ADD VALUE 'reward_submission_approved';

-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "selectedCredentialTemplates" TEXT[];
