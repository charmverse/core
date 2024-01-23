-- AlterTable
ALTER TABLE "Thread" ADD COLUMN     "fieldAnswerId" UUID;

-- AddForeignKey
ALTER TABLE "Thread" ADD CONSTRAINT "Thread_fieldAnswerId_fkey" FOREIGN KEY ("fieldAnswerId") REFERENCES "FormFieldAnswer"("id") ON DELETE SET NULL ON UPDATE CASCADE;
