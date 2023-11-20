-- CreateTable
CREATE TABLE "BlacklistedUser" (
    "userId" UUID NOT NULL,
    "discordId" TEXT,
    "walletAddresses" TEXT[],
    "emails" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BlacklistedUser_pkey" PRIMARY KEY ("userId")
);

-- AddForeignKey
ALTER TABLE "BlacklistedUser" ADD CONSTRAINT "BlacklistedUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
