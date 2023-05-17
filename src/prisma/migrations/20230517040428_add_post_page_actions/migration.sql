-- CreateEnum
CREATE TYPE "PageActionType" AS ENUM ('view');

-- CreateEnum
CREATE TYPE "PostActionType" AS ENUM ('view');

-- CreateTable
CREATE TABLE "PageAction" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID,
    "pageId" UUID NOT NULL,
    "type" "PageActionType" NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PageAction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostAction" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID,
    "postId" UUID NOT NULL,
    "type" "PostActionType" NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PostAction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PageAction_createdBy_type_idx" ON "PageAction"("createdBy", "type");

-- CreateIndex
CREATE INDEX "PageAction_spaceId_type_idx" ON "PageAction"("spaceId", "type");

-- CreateIndex
CREATE INDEX "PostAction_createdBy_type_idx" ON "PostAction"("createdBy", "type");

-- CreateIndex
CREATE INDEX "PostAction_spaceId_type_idx" ON "PostAction"("spaceId", "type");

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
