-- AddForeignKey
ALTER TABLE "UserNotificationMetadata" ADD CONSTRAINT "UserNotificationMetadata_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
