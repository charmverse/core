/*
  Warnings:

  - The values [pro] on the enum `SubscriptionTier` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "SubscriptionTier_new" AS ENUM ('free', 'community', 'enterprise', 'cancelled');
ALTER TABLE "Space" ALTER COLUMN "paidTier" DROP DEFAULT;
ALTER TABLE "Space" ALTER COLUMN "paidTier" TYPE "SubscriptionTier_new" USING ("paidTier"::text::"SubscriptionTier_new");
ALTER TYPE "SubscriptionTier" RENAME TO "SubscriptionTier_old";
ALTER TYPE "SubscriptionTier_new" RENAME TO "SubscriptionTier";
DROP TYPE "SubscriptionTier_old";
ALTER TABLE "Space" ALTER COLUMN "paidTier" SET DEFAULT 'community';
COMMIT;
