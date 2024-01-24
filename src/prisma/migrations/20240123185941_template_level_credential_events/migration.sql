/*
  Warnings:

  - You are about to drop the column `credentialEvents` on the `Space` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "CredentialTemplate" ADD COLUMN     "credentialEvents" "CredentialEventType"[] DEFAULT ARRAY[]::"CredentialEventType"[];

-- AlterTable
ALTER TABLE "Space" DROP COLUMN "credentialEvents";
