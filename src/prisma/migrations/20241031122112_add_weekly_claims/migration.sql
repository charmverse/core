-- CreateTable
CREATE TABLE "WeeklyClaims" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "season" TEXT NOT NULL,
    "week" TEXT NOT NULL,
    "merkleTreeRoot" TEXT NOT NULL,
    "totalClaimable" INTEGER NOT NULL,
    "claims" JSONB NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "WeeklyClaims_week_key" ON "WeeklyClaims"("week");
