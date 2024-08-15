-- CreateTable
CREATE TABLE "ConnectWaitlistSlot" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "initialPosition" SERIAL NOT NULL,
    "fid" INTEGER NOT NULL,
    "username" TEXT NOT NULL,
    "referredByFid" INTEGER,
    "score" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ConnectWaitlistSlot_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ConnectWaitlistSlot_fid_key" ON "ConnectWaitlistSlot"("fid");

-- CreateIndex
CREATE INDEX "ConnectWaitlistSlot_score_idx" ON "ConnectWaitlistSlot"("score");

-- CreateIndex
CREATE INDEX "ConnectWaitlistSlot_referredByFid_idx" ON "ConnectWaitlistSlot"("referredByFid");
