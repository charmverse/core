/*
  Warnings:

  - Added the required column `imageUrl` to the `BuilderNft` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "BuilderNft" ADD COLUMN     "imageUrl" TEXT NOT NULL;
