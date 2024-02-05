-- CreateTable
CREATE TABLE "CharmWallet" (
    "id" UUID NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "userId" UUID,
    "spaceId" UUID,

    CONSTRAINT "CharmWallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharmTransaction" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "amount" INTEGER NOT NULL,
    "from" UUID,
    "to" UUID,
    "metadata" JSONB DEFAULT '{}',

    CONSTRAINT "CharmTransaction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CharmWallet_userId_key" ON "CharmWallet"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "CharmWallet_spaceId_key" ON "CharmWallet"("spaceId");

-- CreateIndex
CREATE INDEX "CharmWallet_id_idx" ON "CharmWallet"("id");

-- AddForeignKey
ALTER TABLE "CharmWallet" ADD CONSTRAINT "CharmWallet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmWallet" ADD CONSTRAINT "CharmWallet_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmTransaction" ADD CONSTRAINT "CharmTransaction_from_fkey" FOREIGN KEY ("from") REFERENCES "CharmWallet"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharmTransaction" ADD CONSTRAINT "CharmTransaction_to_fkey" FOREIGN KEY ("to") REFERENCES "CharmWallet"("id") ON DELETE SET NULL ON UPDATE CASCADE;
