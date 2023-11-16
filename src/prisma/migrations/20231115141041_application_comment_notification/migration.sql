-- AlterTable
ALTER TABLE "DocumentNotification" ADD COLUMN     "applicationCommentId" UUID;

-- AddForeignKey
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_applicationCommentId_fkey" FOREIGN KEY ("applicationCommentId") REFERENCES "ApplicationComment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
