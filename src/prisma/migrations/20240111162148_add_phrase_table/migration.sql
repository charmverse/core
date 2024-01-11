/*
  Warnings:

  - You are about to drop the column `recoveryCode` on the `UserOTP` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[recoveryCodeId]` on the table `UserOTP` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `recoveryCodeId` to the `UserOTP` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "UserOTP" DROP COLUMN "recoveryCode",
ADD COLUMN     "activatedAt" TIMESTAMP(3),
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "recoveryCodeId" UUID NOT NULL;

-- CreateTable
CREATE TABLE "RecoveryCode" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usedAt" TIMESTAMP(3),
    "code" TEXT NOT NULL,

    CONSTRAINT "RecoveryCode_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserOTP_recoveryCodeId_key" ON "UserOTP"("recoveryCodeId");

-- AddForeignKey
ALTER TABLE "UserOTP" ADD CONSTRAINT "UserOTP_recoveryCodeId_fkey" FOREIGN KEY ("recoveryCodeId") REFERENCES "RecoveryCode"("id") ON DELETE CASCADE ON UPDATE CASCADE;
