-- CreateTable
CREATE TABLE "PartnerRewardEvent" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "week" TEXT NOT NULL,
    "season" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "partner" TEXT NOT NULL,
    "reward" JSONB NOT NULL
);

-- CreateIndex
CREATE INDEX "PartnerRewardEvent_userId_idx" ON "PartnerRewardEvent"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PartnerRewardEvent_userId_partner_week_season_key" ON "PartnerRewardEvent"("userId", "partner", "week", "season");

-- AddForeignKey
ALTER TABLE "PartnerRewardEvent" ADD CONSTRAINT "PartnerRewardEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
