-- AlterTable
ALTER TABLE "ConnectWaitlistSlot" ALTER COLUMN "username" DROP NOT NULL;

-- CreateIndex
CREATE INDEX "ConnectWaitlistSlot_githubLogin_idx" ON "ConnectWaitlistSlot"("githubLogin");

-- AddForeignKey
ALTER TABLE "ConnectWaitlistSlot" ADD CONSTRAINT "ConnectWaitlistSlot_referredByFid_fkey" FOREIGN KEY ("referredByFid") REFERENCES "ConnectWaitlistSlot"("fid") ON DELETE SET NULL ON UPDATE CASCADE;
