-- CreateTable
CREATE TABLE "BlacklistedScoutPartnerDeveloper" (
    "scoutPartnerId" TEXT NOT NULL,
    "scoutId" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "BlacklistedScoutPartnerDeveloper_scoutPartnerId_scoutId_key" ON "BlacklistedScoutPartnerDeveloper"("scoutPartnerId", "scoutId");

-- AddForeignKey
ALTER TABLE "BlacklistedScoutPartnerDeveloper" ADD CONSTRAINT "BlacklistedScoutPartnerDeveloper_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlacklistedScoutPartnerDeveloper" ADD CONSTRAINT "BlacklistedScoutPartnerDeveloper_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
