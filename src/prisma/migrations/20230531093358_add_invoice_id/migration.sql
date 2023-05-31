/*
  Warnings:

  - The primary key for the `StripePayment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `paymentId` on the `StripePayment` table. All the data in the column will be lost.
  - Added the required column `invoiceId` to the `StripePayment` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "PaymentStatus" ADD VALUE 'pending';

-- AlterTable
ALTER TABLE "StripePayment" DROP CONSTRAINT "StripePayment_pkey",
DROP COLUMN "paymentId",
ADD COLUMN     "invoiceId" TEXT NOT NULL,
ADD CONSTRAINT "StripePayment_pkey" PRIMARY KEY ("invoiceId");
