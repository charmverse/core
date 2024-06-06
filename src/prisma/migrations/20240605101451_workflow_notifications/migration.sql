-- AlterTable
ALTER TABLE "ProposalEvaluation" ADD COLUMN     "notificationLabels" JSONB;

-- AlterTable
ALTER TABLE "ProposalWorkflow" ADD COLUMN     "draftReminder" BOOLEAN DEFAULT false;
