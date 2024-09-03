-- CreateTable
CREATE TABLE "CryptoEcosystemChild" (
    "parentTitle" TEXT NOT NULL,
    "childTitle" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "CryptoEcosystemChild_parentTitle_idx" ON "CryptoEcosystemChild"("parentTitle");

-- CreateIndex
CREATE INDEX "CryptoEcosystemChild_childTitle_idx" ON "CryptoEcosystemChild"("childTitle");

-- CreateIndex
CREATE UNIQUE INDEX "CryptoEcosystemChild_parentTitle_childTitle_key" ON "CryptoEcosystemChild"("parentTitle", "childTitle");

-- AddForeignKey
ALTER TABLE "CryptoEcosystemChild" ADD CONSTRAINT "CryptoEcosystemChild_parentTitle_fkey" FOREIGN KEY ("parentTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CryptoEcosystemChild" ADD CONSTRAINT "CryptoEcosystemChild_childTitle_fkey" FOREIGN KEY ("childTitle") REFERENCES "CryptoEcosystem"("title") ON DELETE CASCADE ON UPDATE CASCADE;
