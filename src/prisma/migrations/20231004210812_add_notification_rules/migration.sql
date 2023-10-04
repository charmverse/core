-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "notificationRules" JSONB[];

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "notificationRules" JSONB[];
