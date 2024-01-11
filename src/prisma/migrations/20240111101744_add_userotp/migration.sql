-- CreateTable
CREATE TABLE "UserOTP" (
    "id" UUID NOT NULL,
    "secret" TEXT NOT NULL,
    "recoveryCode" TEXT NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "UserOTP_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserOTP_userId_key" ON "UserOTP"("userId");

-- CreateIndex
CREATE INDEX "UserOTP_userId_idx" ON "UserOTP"("userId");

-- AddForeignKey
ALTER TABLE "UserOTP" ADD CONSTRAINT "UserOTP_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
