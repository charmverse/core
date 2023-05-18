-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('success', 'fail');

-- CreateTable
CREATE TABLE "StripePayment" (
    "paymentId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "PaymentStatus" NOT NULL,
    "amount" INTEGER NOT NULL,
    "currency" TEXT NOT NULL,
    "stripeSubscriptionId" UUID NOT NULL,

    CONSTRAINT "StripePayment_pkey" PRIMARY KEY ("paymentId")
);

-- AddForeignKey
ALTER TABLE "StripePayment" ADD CONSTRAINT "StripePayment_stripeSubscriptionId_fkey" FOREIGN KEY ("stripeSubscriptionId") REFERENCES "StripeSubscription"("id") ON DELETE CASCADE ON UPDATE CASCADE;
