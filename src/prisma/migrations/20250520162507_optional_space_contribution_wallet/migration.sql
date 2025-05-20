-- DropForeignKey
ALTER TABLE "SpaceSubscriptionTierChangeEvent" DROP CONSTRAINT "SpaceSubscriptionTierChangeEvent_spaceId_fkey";

-- AlterTable
ALTER TABLE "SpaceSubscriptionContribution" ALTER COLUMN "walletAddress" DROP NOT NULL;

-- AlterTable
ALTER TABLE "SpaceSubscriptionTierChangeEvent" ADD COLUMN     "userId" UUID,
ALTER COLUMN "spaceId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionTierChangeEvent" ADD CONSTRAINT "SpaceSubscriptionTierChangeEvent_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceSubscriptionTierChangeEvent" ADD CONSTRAINT "SpaceSubscriptionTierChangeEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
