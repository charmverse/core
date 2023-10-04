-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "notificationPreferences" JSONB[];

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "notificationPreferences" JSONB[];
