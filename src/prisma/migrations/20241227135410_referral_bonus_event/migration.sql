-- AlterEnum
ALTER TYPE "BuilderEventType" ADD VALUE 'referral_bonus';

-- AlterTable
ALTER TABLE "PointsReceipt" ADD COLUMN     "season" TEXT;
