/*
  Warnings:

  - You are about to drop the column `agreedToTOS` on the `Scout` table. All the data in the column will be lost.
  - You are about to drop the column `onboarded` on the `Scout` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Scout" DROP COLUMN "agreedToTOS",
DROP COLUMN "onboarded",
ADD COLUMN     "agreedToTermsAt" TIMESTAMP(3),
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "onboardedAt" TIMESTAMP(3);
