/*
  Warnings:

  - Changed the type of `userId` on the `ProposalRubricCriteriaAnswer` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "ProposalRubricCriteriaAnswer"
RENAME COLUMN "userId" TO "oldUserId";

ALTER TABLE "ProposalRubricCriteriaAnswer"
ADD COLUMN "userId" UUID;

UPDATE "ProposalRubricCriteriaAnswer"
SET "userId" = "oldUserId"::UUID;

ALTER TABLE "ProposalRubricCriteriaAnswer"
ALTER COLUMN "userId" SET NOT NULL;

ALTER TABLE "ProposalRubricCriteriaAnswer"
DROP COLUMN "oldUserId";

-- CreateIndex
CREATE UNIQUE INDEX "ProposalRubricCriteriaAnswer_userId_rubricCriteriaId_key" ON "ProposalRubricCriteriaAnswer"("userId", "rubricCriteriaId");

-- AddForeignKey
ALTER TABLE "ProposalRubricCriteriaAnswer" ADD CONSTRAINT "ProposalRubricCriteriaAnswer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
