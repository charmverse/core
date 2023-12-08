-- AlterTable
ALTER TABLE "Bounty" ADD COLUMN     "proposalId" UUID;

-- AddForeignKey
ALTER TABLE "Bounty" ADD CONSTRAINT "Bounty_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE SET NULL ON UPDATE CASCADE;
