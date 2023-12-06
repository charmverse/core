-- AlterTable
ALTER TABLE "SpaceRole" ADD COLUMN     "unlockProtocolGateId" UUID;

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
    "unlockProtocolGateToRoleId" TEXT NOT NULL,

    CONSTRAINT "UnlockProtocolGate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnlockProtocolGateToRole" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "roleId" UUID NOT NULL,
    "unlockProtocolGateId" UUID NOT NULL,

    CONSTRAINT "UnlockProtocolGateToRole_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "UnlockProtocolGate_spaceId_idx" ON "UnlockProtocolGate"("spaceId");

-- CreateIndex
CREATE INDEX "UnlockProtocolGateToRole_unlockProtocolGateId_idx" ON "UnlockProtocolGateToRole"("unlockProtocolGateId");

-- CreateIndex
CREATE INDEX "UnlockProtocolGateToRole_roleId_idx" ON "UnlockProtocolGateToRole"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "UnlockProtocolGateToRole_unlockProtocolGateId_roleId_key" ON "UnlockProtocolGateToRole"("unlockProtocolGateId", "roleId");

-- AddForeignKey
ALTER TABLE "UserTokenGate" ADD CONSTRAINT "UserTokenGate_unlockProtocolGateId_fkey" FOREIGN KEY ("unlockProtocolGateId") REFERENCES "UnlockProtocolGate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceRole" ADD CONSTRAINT "SpaceRole_unlockProtocolGateId_fkey" FOREIGN KEY ("unlockProtocolGateId") REFERENCES "UnlockProtocolGate"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnlockProtocolGate" ADD CONSTRAINT "UnlockProtocolGate_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnlockProtocolGateToRole" ADD CONSTRAINT "UnlockProtocolGateToRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnlockProtocolGateToRole" ADD CONSTRAINT "UnlockProtocolGateToRole_unlockProtocolGateId_fkey" FOREIGN KEY ("unlockProtocolGateId") REFERENCES "UnlockProtocolGate"("id") ON DELETE CASCADE ON UPDATE CASCADE;
