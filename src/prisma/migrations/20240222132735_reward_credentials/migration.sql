-- AlterEnum
ALTER TYPE "AttestationType" ADD VALUE 'reward';

-- AlterEnum
ALTER TYPE "CredentialEventType" ADD VALUE 'reward_submission_approved';

-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "selectedCredentialTemplates" TEXT[];

-- AlterTable
ALTER TABLE "IssuedCredential" ADD COLUMN     "applicationId" UUID,
ALTER COLUMN "proposalId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "IssuedCredential" ADD CONSTRAINT "IssuedCredential_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;
