-- CreateTable
CREATE TABLE "BlacklistedSpaceUser" (
    "userId" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "discordId" TEXT,
    "walletAddresses" TEXT[],
    "emails" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "BlacklistedSpaceUser_userId_spaceId_key" ON "BlacklistedSpaceUser"("userId", "spaceId");

-- AddForeignKey
ALTER TABLE "BlacklistedSpaceUser" ADD CONSTRAINT "BlacklistedSpaceUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlacklistedSpaceUser" ADD CONSTRAINT "BlacklistedSpaceUser_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
