-- CreateTable
CREATE TABLE "ProductUpdatesFarcasterFrame" (
    "id" UUID NOT NULL,
    "text" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "authorFid" INTEGER NOT NULL,
    "createdBy" UUID NOT NULL,
    "projectId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtLocal" TEXT NOT NULL,

    CONSTRAINT "ProductUpdatesFarcasterFrame_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ProductUpdatesFarcasterFrame" ADD CONSTRAINT "ProductUpdatesFarcasterFrame_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductUpdatesFarcasterFrame" ADD CONSTRAINT "ProductUpdatesFarcasterFrame_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
