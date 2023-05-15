-- CreateEnum
CREATE TYPE "PageActionType" AS ENUM ('view');

-- CreateTable
CREATE TABLE "UserPageAction" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "pageId" UUID NOT NULL,
    "type" "PageActionType" NOT NULL,
    "spaceId" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "UserPostAction" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "type" "PageActionType" NOT NULL,
    "spaceId" UUID NOT NULL
);

-- CreateIndex
CREATE INDEX "UserPageAction_createdBy_type_idx" ON "UserPageAction"("createdBy", "type");

-- CreateIndex
CREATE UNIQUE INDEX "UserPageAction_createdBy_createdAt_key" ON "UserPageAction"("createdBy", "createdAt");

-- CreateIndex
CREATE INDEX "UserPostAction_createdBy_type_idx" ON "UserPostAction"("createdBy", "type");

-- CreateIndex
CREATE UNIQUE INDEX "UserPostAction_createdBy_createdAt_key" ON "UserPostAction"("createdBy", "createdAt");

-- AddForeignKey
ALTER TABLE "UserPageAction" ADD CONSTRAINT "UserPageAction_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "Page"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPageAction" ADD CONSTRAINT "UserPageAction_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPageAction" ADD CONSTRAINT "UserPageAction_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPostAction" ADD CONSTRAINT "UserPostAction_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPostAction" ADD CONSTRAINT "UserPostAction_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPostAction" ADD CONSTRAINT "UserPostAction_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
