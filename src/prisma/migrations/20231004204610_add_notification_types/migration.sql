-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "notificationTypes" JSONB[];

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "notificationTypes" JSONB[];
