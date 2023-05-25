-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "tagId" UUID;

-- CreateTable
CREATE TABLE "PostTag" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "spaceId" UUID NOT NULL,

    CONSTRAINT "PostTag_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PostTag_spaceId_name_key" ON "PostTag"("spaceId", "name");

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "PostTag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostTag" ADD CONSTRAINT "PostTag_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
