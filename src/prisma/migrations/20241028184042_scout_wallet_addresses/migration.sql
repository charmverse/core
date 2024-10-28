-- CreateTable
CREATE TABLE "ScoutWallet" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "address" TEXT NOT NULL,
    "scoutId" UUID NOT NULL,

    CONSTRAINT "ScoutWallet_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ScoutWallet_address_key" ON "ScoutWallet"("address");

-- AddForeignKey
ALTER TABLE "ScoutWallet" ADD CONSTRAINT "ScoutWallet_scoutId_fkey" FOREIGN KEY ("scoutId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
