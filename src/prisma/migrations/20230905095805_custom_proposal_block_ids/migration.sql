/*
  Warnings:

  - The primary key for the `ProposalBlock` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[id,spaceId]` on the table `ProposalBlock` will be added. If there are existing duplicate values, this will fail.
  - Changed the type of `type` on the `ProposalBlock` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "ProposalBlock" DROP CONSTRAINT "ProposalBlock_pkey",
ALTER COLUMN "id" SET DATA TYPE TEXT,
DROP COLUMN "type",
ADD COLUMN     "type" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "ProposalBlock_id_spaceId_key" ON "ProposalBlock"("id", "spaceId");
