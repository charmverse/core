/*
  Warnings:

  - The values [name] on the enum `MemberPropertyType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "MemberPropertyType_new" AS ENUM ('text', 'text_multiline', 'number', 'email', 'phone', 'url', 'select', 'multiselect', 'role', 'profile_pic', 'timezone', 'discord', 'twitter', 'bio', 'join_date', 'linked_in', 'github', 'google', 'telegram', 'wallet');
ALTER TABLE "MemberProperty" ALTER COLUMN "type" TYPE "MemberPropertyType_new" USING ("type"::text::"MemberPropertyType_new");
ALTER TYPE "MemberPropertyType" RENAME TO "MemberPropertyType_old";
ALTER TYPE "MemberPropertyType_new" RENAME TO "MemberPropertyType";
DROP TYPE "MemberPropertyType_old";
COMMIT;
