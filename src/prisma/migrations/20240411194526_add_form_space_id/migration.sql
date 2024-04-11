-- AlterTable
ALTER TABLE "Form" ADD COLUMN     "spaceId" UUID;

-- AddForeignKey
ALTER TABLE "Form" ADD CONSTRAINT "Form_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
