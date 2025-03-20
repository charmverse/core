-- CreateTable
CREATE TABLE "WalletSanctionStatus" (
    "address" TEXT NOT NULL,
    "isSanctioned" BOOLEAN NOT NULL DEFAULT false,
    "checkedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WalletSanctionStatus_pkey" PRIMARY KEY ("address")
);

-- CreateIndex
CREATE UNIQUE INDEX "WalletSanctionStatus_address_key" ON "WalletSanctionStatus"("address");
