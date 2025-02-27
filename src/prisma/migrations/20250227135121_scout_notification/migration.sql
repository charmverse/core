-- CreateEnum
CREATE TYPE "ScoutNotificationChannel" AS ENUM ('farcaster', 'email');

-- CreateTable
CREATE TABLE "ScoutNotification" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "sentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "channel" "ScoutNotificationChannel" NOT NULL,
    "notificationType" TEXT NOT NULL,

    CONSTRAINT "ScoutNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutFarcasterNotification" (
    "id" UUID NOT NULL,
    "fid" INTEGER NOT NULL,
    "notificationId" UUID NOT NULL,

    CONSTRAINT "ScoutFarcasterNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutEmailNotification" (
    "id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "templateVariables" JSONB NOT NULL,
    "notificationId" UUID NOT NULL,

    CONSTRAINT "ScoutEmailNotification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ScoutNotification_userId_idx" ON "ScoutNotification"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoutNotification_userId_notificationType_channel_key" ON "ScoutNotification"("userId", "notificationType", "channel");

-- CreateIndex
CREATE INDEX "ScoutFarcasterNotification_notificationId_idx" ON "ScoutFarcasterNotification"("notificationId");

-- CreateIndex
CREATE INDEX "ScoutEmailNotification_notificationId_idx" ON "ScoutEmailNotification"("notificationId");

-- AddForeignKey
ALTER TABLE "ScoutNotification" ADD CONSTRAINT "ScoutNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutFarcasterNotification" ADD CONSTRAINT "ScoutFarcasterNotification_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES "ScoutNotification"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutEmailNotification" ADD CONSTRAINT "ScoutEmailNotification_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES "ScoutNotification"("id") ON DELETE CASCADE ON UPDATE CASCADE;
