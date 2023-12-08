/*
  Warnings:

  - Added the required column `type` to the `TokenGate` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "TokenGate" ADD COLUMN     "type" TEXT NOT NULL;
