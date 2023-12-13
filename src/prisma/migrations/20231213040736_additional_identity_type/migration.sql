-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "IdentityType" ADD VALUE 'Lens';
ALTER TYPE "IdentityType" ADD VALUE 'Farcaster';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "MemberPropertyType" ADD VALUE 'google';
ALTER TYPE "MemberPropertyType" ADD VALUE 'telegram';
ALTER TYPE "MemberPropertyType" ADD VALUE 'wallet';

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "primaryMemberIdentity" "IdentityType";
