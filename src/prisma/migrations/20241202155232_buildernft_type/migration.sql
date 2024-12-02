-- CreateEnum
CREATE TYPE "BuilderNftType" AS ENUM ('season_1_starter_pack');

-- AlterTable
ALTER TABLE "BuilderNft" ADD COLUMN     "nftType" "BuilderNftType";
