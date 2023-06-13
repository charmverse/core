/*
  Warnings:

  - You are about to drop the column `createdBy` on the `StripeSubscription` table. All the data in the column will be lost.
  - You are about to drop the `StripePayment` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[subscriptionId]` on the table `StripeSubscription` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `priceId` to the `StripeSubscription` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status` to the `StripeSubscription` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('active', 'pending', 'cancelled', 'cancelAtEnd');

-- DropForeignKey
ALTER TABLE "StripePayment" DROP CONSTRAINT "StripePayment_stripeSubscriptionId_fkey";

-- DropForeignKey
ALTER TABLE "StripeSubscription" DROP CONSTRAINT "StripeSubscription_createdBy_fkey";

-- AlterTable
ALTER TABLE "StripeSubscription" DROP COLUMN "createdBy",
ADD COLUMN     "priceId" TEXT NOT NULL,
ADD COLUMN     "status" "SubscriptionStatus" NOT NULL;

-- DropTable
DROP TABLE "StripePayment";

-- DropEnum
DROP TYPE "PaymentStatus";

-- CreateIndex
CREATE UNIQUE INDEX "StripeSubscription_subscriptionId_key" ON "StripeSubscription"("subscriptionId");
