/*
  Warnings:

  - Added the required column `type` to the `GitcoinProjectAttestation` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "GitcoinProjectAttestationType" AS ENUM ('application', 'profile');

-- AlterTable
ALTER TABLE "GitcoinProjectAttestation" ADD COLUMN     "type" "GitcoinProjectAttestationType" NOT NULL;
