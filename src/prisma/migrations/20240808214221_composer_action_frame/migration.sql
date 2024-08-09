-- CreateTable
CREATE TABLE "ComposerActionFrame" (
    "id" UUID NOT NULL,
    "text" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "authorFid" INTEGER NOT NULL,
    "projectId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ComposerActionFrame_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ComposerActionFrame" ADD CONSTRAINT "ComposerActionFrame_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
