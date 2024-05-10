-- CreateTable
CREATE TABLE "IssuedCredentialNotification" (
    "id" UUID NOT NULL,
    "notificationMetadataId" UUID NOT NULL,
    "issuedCredentialId" UUID NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "IssuedCredentialNotification_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "IssuedCredentialNotification" ADD CONSTRAINT "IssuedCredentialNotification_notificationMetadataId_fkey" FOREIGN KEY ("notificationMetadataId") REFERENCES "UserNotificationMetadata"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IssuedCredentialNotification" ADD CONSTRAINT "IssuedCredentialNotification_issuedCredentialId_fkey" FOREIGN KEY ("issuedCredentialId") REFERENCES "IssuedCredential"("id") ON DELETE CASCADE ON UPDATE CASCADE;
