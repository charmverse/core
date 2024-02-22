-- AlterEnum
ALTER TYPE "AttestationType" ADD VALUE 'reward';

-- AlterEnum
ALTER TYPE "CredentialEventType" ADD VALUE 'reward_submission_approved';

-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "selectedCredentialTemplates" TEXT[];

-- AlterTable
ALTER TABLE "IssuedCredential" ADD COLUMN     "rewardId" UUID,
ALTER COLUMN "proposalId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "IssuedCredential" ADD CONSTRAINT "IssuedCredential_rewardId_fkey" FOREIGN KEY ("rewardId") REFERENCES "Bounty"("id") ON DELETE CASCADE ON UPDATE CASCADE;
