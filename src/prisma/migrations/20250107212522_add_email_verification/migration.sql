-- CreateTable
CREATE TABLE "ScoutEmailVerification" (
    "code" TEXT NOT NULL,
    "sentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "email" TEXT NOT NULL,
    "scoutId" UUID NOT NULL,

    CONSTRAINT "ScoutEmailVerification_pkey" PRIMARY KEY ("code")
);

-- CreateIndex
CREATE INDEX "ScoutEmailVerification_completedAt_scoutId_idx" ON "ScoutEmailVerification"("completedAt", "scoutId");

-- AddForeignKey
ALTER TABLE "ScoutEmailVerification" ADD CONSTRAINT "ScoutEmailVerification_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
