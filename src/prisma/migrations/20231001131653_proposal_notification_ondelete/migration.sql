-- DropForeignKey
ALTER TABLE "ProposalNotification" DROP CONSTRAINT "ProposalNotification_proposalId_fkey";

-- AddForeignKey
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;
