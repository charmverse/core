-- AlterTable
ALTER TABLE "SpaceRole" ADD COLUMN     "unlockProtocolGateId" UUID;

-- AlterTable
ALTER TABLE "TokenGateToRole" ADD COLUMN     "unlockProtocolGateId" UUID;

-- AlterTable
ALTER TABLE "UserTokenGate" ADD COLUMN     "unlockProtocolGateId" UUID;

-- CreateTable
CREATE TABLE "UnlockProtocolGate" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "contract" TEXT NOT NULL,
    "chainId" INTEGER NOT NULL,
    "userRole" TEXT,
    "accessTypes" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "UnlockProtocolGate_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "UnlockProtocolGate_spaceId_idx" ON "UnlockProtocolGate"("spaceId");

-- AddForeignKey
ALTER TABLE "UserTokenGate" ADD CONSTRAINT "UserTokenGate_unlockProtocolGateId_fkey" FOREIGN KEY ("unlockProtocolGateId") REFERENCES "UnlockProtocolGate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceRole" ADD CONSTRAINT "SpaceRole_unlockProtocolGateId_fkey" FOREIGN KEY ("unlockProtocolGateId") REFERENCES "UnlockProtocolGate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnlockProtocolGate" ADD CONSTRAINT "UnlockProtocolGate_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TokenGateToRole" ADD CONSTRAINT "TokenGateToRole_unlockProtocolGateId_fkey" FOREIGN KEY ("unlockProtocolGateId") REFERENCES "UnlockProtocolGate"("id") ON DELETE SET NULL ON UPDATE CASCADE;
