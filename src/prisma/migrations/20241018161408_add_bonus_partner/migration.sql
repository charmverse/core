-- AlterTable
ALTER TABLE "GithubRepo" ADD COLUMN     "bonusPartner" TEXT;

-- CreateIndex
CREATE INDEX "GithubRepo_bonusPartner_idx" ON "GithubRepo"("bonusPartner");
