-- CreateTable
CREATE TABLE "FarcasterUser" (
    "fid" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "account" JSONB NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "FarcasterUser_pkey" PRIMARY KEY ("fid")
);

-- CreateIndex
CREATE UNIQUE INDEX "FarcasterUser_fid_key" ON "FarcasterUser"("fid");

-- CreateIndex
CREATE UNIQUE INDEX "FarcasterUser_userId_key" ON "FarcasterUser"("userId");

-- CreateIndex
CREATE INDEX "FarcasterUser_userId_idx" ON "FarcasterUser"("userId");

-- AddForeignKey
ALTER TABLE "FarcasterUser" ADD CONSTRAINT "FarcasterUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
