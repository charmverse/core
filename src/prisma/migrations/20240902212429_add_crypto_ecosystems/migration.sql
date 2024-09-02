/*
  Warnings:

  - You are about to drop the column `raw` on the `CryptoEcosystemPullRequest` table. All the data in the column will be lost.
  - Added the required column `date` to the `CryptoEcosystemPullRequest` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CryptoEcosystemAuthor" ADD COLUMN     "xtra" JSONB;

-- AlterTable
ALTER TABLE "CryptoEcosystemPullRequest" DROP COLUMN "raw",
ADD COLUMN     "date" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "xtra" JSONB;

-- AlterTable
ALTER TABLE "CryptoEcosystemRepo" ADD COLUMN     "xtra" JSONB;
