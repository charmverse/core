-- CreateTable
CREATE TABLE "ScoutAppNotification" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "notificationType" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "meta" JSONB NOT NULL,

    CONSTRAINT "ScoutAppNotification_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ScoutAppNotification" ADD CONSTRAINT "ScoutAppNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
