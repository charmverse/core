-- CreateTable
CREATE TABLE "BlacklistedScoutPartnerDeveloper" (
    "scoutPartnerId" TEXT NOT NULL,
    "developerId" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "BlacklistedScoutPartnerDeveloper_scoutPartnerId_developerId_key" ON "BlacklistedScoutPartnerDeveloper"("scoutPartnerId", "developerId");

-- AddForeignKey
ALTER TABLE "BlacklistedScoutPartnerDeveloper" ADD CONSTRAINT "BlacklistedScoutPartnerDeveloper_scoutPartnerId_fkey" FOREIGN KEY ("scoutPartnerId") REFERENCES "ScoutPartner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlacklistedScoutPartnerDeveloper" ADD CONSTRAINT "BlacklistedScoutPartnerDeveloper_developerId_fkey" FOREIGN KEY ("developerId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
