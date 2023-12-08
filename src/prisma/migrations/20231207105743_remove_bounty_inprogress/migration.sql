/*
  Warnings:

  - The values [inProgress] on the enum `BountyStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "BountyStatus_new" AS ENUM ('suggestion', 'open', 'complete', 'paid');
ALTER TABLE "Bounty" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Bounty" ALTER COLUMN "status" TYPE "BountyStatus_new" USING ("status"::text::"BountyStatus_new");
ALTER TYPE "BountyStatus" RENAME TO "BountyStatus_old";
ALTER TYPE "BountyStatus_new" RENAME TO "BountyStatus";
DROP TYPE "BountyStatus_old";
ALTER TABLE "Bounty" ALTER COLUMN "status" SET DEFAULT 'open';
COMMIT;
