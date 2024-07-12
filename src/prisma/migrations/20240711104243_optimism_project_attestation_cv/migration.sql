-- AlterTable
ALTER TABLE "OptimismProjectAttestation" ADD COLUMN     "projectId" UUID;

-- AddForeignKey
ALTER TABLE "OptimismProjectAttestation" ADD CONSTRAINT "OptimismProjectAttestation_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE SET NULL ON UPDATE CASCADE;
