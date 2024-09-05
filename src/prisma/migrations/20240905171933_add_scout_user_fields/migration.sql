-- AlterTable
ALTER TABLE "Scout" ADD COLUMN     "agreedToTOS" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "onboarded" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "sendMarketing" BOOLEAN NOT NULL DEFAULT false;
