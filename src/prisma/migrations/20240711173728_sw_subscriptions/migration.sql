-- CreateTable
CREATE TABLE "ServiceWorkerSubscriptions" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),
    "subscription" JSONB NOT NULL,

    CONSTRAINT "ServiceWorkerSubscriptions_pkey" PRIMARY KEY ("id")
);
