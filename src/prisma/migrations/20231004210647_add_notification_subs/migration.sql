-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "notificationSubscriptions" JSONB[];

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "notificationSubscriptions" JSONB[];
