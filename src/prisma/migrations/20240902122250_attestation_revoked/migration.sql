-- AlterTable
ALTER TABLE "CharmProjectCredential" ADD COLUMN     "projectAttestationRevoked" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "GitcoinProjectAttestation" ADD COLUMN     "projectAttestationRevoked" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "OptimismProjectAttestation" ADD COLUMN     "projectAttestationRevoked" BOOLEAN NOT NULL DEFAULT false;
