/*
  Warnings:

  - You are about to drop the `UserPageAction` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserPostAction` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserPageAction" DROP CONSTRAINT "UserPageAction_createdBy_fkey";

-- DropForeignKey
ALTER TABLE "UserPageAction" DROP CONSTRAINT "UserPageAction_pageId_fkey";

-- DropForeignKey
ALTER TABLE "UserPageAction" DROP CONSTRAINT "UserPageAction_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "UserPostAction" DROP CONSTRAINT "UserPostAction_createdBy_fkey";

-- DropForeignKey
ALTER TABLE "UserPostAction" DROP CONSTRAINT "UserPostAction_postId_fkey";

-- DropForeignKey
ALTER TABLE "UserPostAction" DROP CONSTRAINT "UserPostAction_spaceId_fkey";

-- DropTable
DROP TABLE "UserPageAction";

-- DropTable
DROP TABLE "UserPostAction";

-- CreateTable
CREATE TABLE "PageAction" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "pageId" UUID NOT NULL,
    "type" "PageActionType" NOT NULL,
    "spaceId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "PostAction" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "type" "PostActionType" NOT NULL,
    "spaceId" UUID NOT NULL
);

-- CreateIndex
CREATE INDEX "PageAction_createdBy_type_idx" ON "PageAction"("createdBy", "type");

-- CreateIndex
CREATE INDEX "PageAction_spaceId_type_idx" ON "PageAction"("spaceId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "PageAction_createdBy_createdAt_key" ON "PageAction"("createdBy", "createdAt");

-- CreateIndex
CREATE INDEX "PostAction_createdBy_type_idx" ON "PostAction"("createdBy", "type");

-- CreateIndex
CREATE INDEX "PostAction_spaceId_type_idx" ON "PostAction"("spaceId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "PostAction_createdBy_createdAt_key" ON "PostAction"("createdBy", "createdAt");

-- AddForeignKey
ALTER TABLE "PageAction" ADD CONSTRAINT "PageAction_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "Page"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PageAction" ADD CONSTRAINT "PageAction_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PageAction" ADD CONSTRAINT "PageAction_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostAction" ADD CONSTRAINT "PostAction_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostAction" ADD CONSTRAINT "PostAction_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostAction" ADD CONSTRAINT "PostAction_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
