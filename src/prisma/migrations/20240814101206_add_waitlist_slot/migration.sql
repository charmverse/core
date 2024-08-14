-- CreateTable
CREATE TABLE "ConnectWaitlistSlot" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "initialPosition" SERIAL NOT NULL,
    "fid" INTEGER NOT NULL,
    "username" TEXT NOT NULL,
    "referredByFid" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,

    CONSTRAINT "ConnectWaitlistSlot_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ConnectWaitlistSlot_fid_key" ON "ConnectWaitlistSlot"("fid");

-- CreateIndex
CREATE INDEX "ConnectWaitlistSlot_score_idx" ON "ConnectWaitlistSlot"("score");
