-- CreateTable
CREATE TABLE "ScoutAppNotification" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "notificationType" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "templateVariables" JSONB NOT NULL,

    CONSTRAINT "ScoutAppNotification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutAppNotification_userId_idx" ON "ScoutAppNotification"("userId");

-- CreateIndex
CREATE INDEX "ScoutAppNotification_read_idx" ON "ScoutAppNotification"("read");

-- CreateIndex
CREATE INDEX "ScoutEmailNotification_userId_idx" ON "ScoutEmailNotification"("userId");

-- CreateIndex
CREATE INDEX "ScoutFarcasterNotification_userId_idx" ON "ScoutFarcasterNotification"("userId");

-- AddForeignKey
ALTER TABLE "ScoutAppNotification" ADD CONSTRAINT "ScoutAppNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
