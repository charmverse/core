/*
  Warnings:

  - You are about to drop the column `builderId` on the `NFTPurchaseEvent` table. All the data in the column will be lost.
  - You are about to drop the column `chain` on the `NFTPurchaseEvent` table. All the data in the column will be lost.
  - You are about to drop the column `contractAddress` on the `NFTPurchaseEvent` table. All the data in the column will be lost.
  - You are about to drop the column `points` on the `NFTPurchaseEvent` table. All the data in the column will be lost.
  - You are about to drop the column `tokenId` on the `NFTPurchaseEvent` table. All the data in the column will be lost.
  - Added the required column `builderNftId` to the `NFTPurchaseEvent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pointsValue` to the `NFTPurchaseEvent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tokensPurchased` to the `NFTPurchaseEvent` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "NFTPurchaseEvent" DROP CONSTRAINT "NFTPurchaseEvent_builderId_fkey";

-- DropIndex
DROP INDEX "NFTPurchaseEvent_builderId_idx";

-- AlterTable
ALTER TABLE "NFTPurchaseEvent" DROP COLUMN "builderId",
DROP COLUMN "chain",
DROP COLUMN "contractAddress",
DROP COLUMN "points",
DROP COLUMN "tokenId",
ADD COLUMN     "builderNftId" UUID NOT NULL,
ADD COLUMN     "pointsValue" INTEGER NOT NULL,
ADD COLUMN     "tokensPurchased" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "BuilderNft" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "builderId" UUID NOT NULL,
    "contract" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "season" INTEGER NOT NULL,
    "contractAddress" TEXT NOT NULL,
    "tokenId" INTEGER NOT NULL,

    CONSTRAINT "BuilderNft_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_contractAddress_tokenId_chainId_key" ON "BuilderNft"("contractAddress", "tokenId", "chainId");

-- CreateIndex
CREATE UNIQUE INDEX "BuilderNft_builderId_season_key" ON "BuilderNft"("builderId", "season");

-- AddForeignKey
ALTER TABLE "NFTPurchaseEvent" ADD CONSTRAINT "NFTPurchaseEvent_builderNftId_fkey" FOREIGN KEY ("builderNftId") REFERENCES "BuilderNft"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BuilderNft" ADD CONSTRAINT "BuilderNft_builderId_fkey" FOREIGN KEY ("builderId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
