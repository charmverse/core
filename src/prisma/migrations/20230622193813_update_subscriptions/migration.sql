/*
  Warnings:

  - You are about to drop the column `blockQuota` on the `StripeSubscription` table. All the data in the column will be lost.
  - You are about to drop the column `period` on the `StripeSubscription` table. All the data in the column will be lost.
  - You are about to drop the column `priceId` on the `StripeSubscription` table. All the data in the column will be lost.
  - You are about to drop the column `productId` on the `StripeSubscription` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `StripeSubscription` table. All the data in the column will be lost.

*/
-- AlterEnum
ALTER TYPE "SubscriptionTier" ADD VALUE 'cancelled';

-- AlterTable
ALTER TABLE "StripeSubscription" DROP COLUMN "blockQuota",
DROP COLUMN "period",
DROP COLUMN "priceId",
DROP COLUMN "productId",
DROP COLUMN "status";

-- DropEnum
DROP TYPE "SubscriptionStatus";
