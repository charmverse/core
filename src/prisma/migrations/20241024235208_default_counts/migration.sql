-- AlterTable
ALTER TABLE "UserAllTimeStats" ALTER COLUMN "pointsEarnedAsBuilder" SET DEFAULT 0,
ALTER COLUMN "pointsEarnedAsScout" SET DEFAULT 0;

-- AlterTable
ALTER TABLE "UserSeasonStats" ALTER COLUMN "pointsEarnedAsBuilder" SET DEFAULT 0,
ALTER COLUMN "pointsEarnedAsScout" SET DEFAULT 0,
ALTER COLUMN "nftOwners" SET DEFAULT 0,
ALTER COLUMN "nftsSold" SET DEFAULT 0;
