-- CreateTable
CREATE TABLE "ScoutTelegramUser" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "scoutId" UUID NOT NULL,
    "telegramId" BIGINT NOT NULL,
    "username" TEXT NOT NULL,
    "avatar" TEXT,

    CONSTRAINT "ScoutTelegramUser_pkey" PRIMARY KEY ("telegramId")
);

-- CreateIndex
CREATE UNIQUE INDEX "ScoutTelegramUser_scoutId_key" ON "ScoutTelegramUser"("scoutId");

-- CreateIndex
CREATE INDEX "ScoutTelegramUser_telegramId_idx" ON "ScoutTelegramUser"("telegramId");

-- CreateIndex
CREATE INDEX "ScoutTelegramUser_scoutId_idx" ON "ScoutTelegramUser"("scoutId");

-- AddForeignKey
ALTER TABLE "ScoutTelegramUser" ADD CONSTRAINT "ScoutTelegramUser_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
