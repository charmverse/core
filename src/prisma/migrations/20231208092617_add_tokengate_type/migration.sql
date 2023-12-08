/*
  Warnings:

  - Added the required column `type` to the `TokenGate` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "TokenGateType" AS ENUM ('lit', 'unlock');

-- AlterTable
ALTER TABLE "TokenGate" ADD COLUMN     "type" "TokenGateType" NOT NULL;
