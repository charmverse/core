-- CreateEnum
CREATE TYPE "MessageSender" AS ENUM ('user', 'agent');

-- CreateTable
CREATE TABLE "AgentTelegramMessage" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sender" "MessageSender" NOT NULL,
    "message" TEXT NOT NULL,
    "toolCalls" JSONB,
    "userTelegramId" BIGINT NOT NULL,
    "messageTelegramId" BIGINT NOT NULL,

    CONSTRAINT "AgentTelegramMessage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "AgentTelegramMessage_userTelegramId_idx" ON "AgentTelegramMessage"("userTelegramId");
