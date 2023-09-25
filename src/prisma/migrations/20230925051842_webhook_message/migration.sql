-- DropIndex
DROP INDEX "BountyNotification_id_key";

-- DropIndex
DROP INDEX "CardNotification_id_key";

-- DropIndex
DROP INDEX "DocumentNotification_id_key";

-- DropIndex
DROP INDEX "PostNotification_id_key";

-- DropIndex
DROP INDEX "ProposalNotification_id_key";

-- DropIndex
DROP INDEX "VoteNotification_id_key";

-- AlterTable
ALTER TABLE "BountyNotification" ADD CONSTRAINT "BountyNotification_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "CardNotification" ADD CONSTRAINT "CardNotification_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "DocumentNotification" ADD CONSTRAINT "DocumentNotification_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "PostNotification" ADD CONSTRAINT "PostNotification_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "ProposalNotification" ADD CONSTRAINT "ProposalNotification_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "VoteNotification" ADD CONSTRAINT "VoteNotification_pkey" PRIMARY KEY ("id");

-- CreateTable
CREATE TABLE "WebhookMessage" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processed" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "WebhookMessage_pkey" PRIMARY KEY ("id")
);
