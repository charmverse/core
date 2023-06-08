/*
  Warnings:

  - A unique constraint covering the columns `[spaceId,publicContext]` on the table `InviteLink` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "PublicInviteLinkContext" AS ENUM ('proposals');

-- AlterTable
ALTER TABLE "InviteLink" ADD COLUMN     "publicContext" "PublicInviteLinkContext";

-- CreateIndex
CREATE UNIQUE INDEX "InviteLink_spaceId_publicContext_key" ON "InviteLink"("spaceId", "publicContext");
