-- CreateTable
CREATE TABLE "PostToPostTag" (
    "id" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "postTagId" UUID NOT NULL,

    CONSTRAINT "PostToPostTag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostTag" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PostTag_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PostToPostTag_postId_idx" ON "PostToPostTag"("postId");

-- CreateIndex
CREATE INDEX "PostToPostTag_postTagId_idx" ON "PostToPostTag"("postTagId");

-- CreateIndex
CREATE UNIQUE INDEX "PostToPostTag_postId_postTagId_key" ON "PostToPostTag"("postId", "postTagId");

-- CreateIndex
CREATE INDEX "PostTag_spaceId_idx" ON "PostTag"("spaceId");

-- CreateIndex
CREATE UNIQUE INDEX "PostTag_spaceId_name_key" ON "PostTag"("spaceId", "name");

-- AddForeignKey
ALTER TABLE "PostToPostTag" ADD CONSTRAINT "PostToPostTag_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostToPostTag" ADD CONSTRAINT "PostToPostTag_postTagId_fkey" FOREIGN KEY ("postTagId") REFERENCES "PostTag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostTag" ADD CONSTRAINT "PostTag_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
