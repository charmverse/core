-- CreateTable
CREATE TABLE "CustomNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "CustomNotification_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CustomNotification" ADD CONSTRAINT "CustomNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;
