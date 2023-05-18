-- CreateEnum
CREATE TYPE "UserSpaceActionType" AS ENUM ('view_page');

-- CreateTable
CREATE TABLE "UserSpaceAction" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID,
    "pageId" UUID,
    "postId" UUID,
    "action" "UserSpaceActionType" NOT NULL,
    "pageType" TEXT,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "UserSpaceAction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "UserSpaceAction_createdBy_action_idx" ON "UserSpaceAction"("createdBy", "action");

-- CreateIndex
CREATE INDEX "UserSpaceAction_spaceId_action_idx" ON "UserSpaceAction"("spaceId", "action");

-- AddForeignKey
ALTER TABLE "UserSpaceAction" ADD CONSTRAINT "UserSpaceAction_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "Page"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSpaceAction" ADD CONSTRAINT "UserSpaceAction_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSpaceAction" ADD CONSTRAINT "UserSpaceAction_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSpaceAction" ADD CONSTRAINT "UserSpaceAction_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
