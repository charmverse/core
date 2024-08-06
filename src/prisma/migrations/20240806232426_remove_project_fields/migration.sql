/*
  Warnings:

  - You are about to drop the column `blog` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `communityUrl` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `demoUrl` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `excerpt` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `mirror` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `otherUrl` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `website` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `github` on the `ProjectMember` table. All the data in the column will be lost.
  - You are about to drop the column `linkedin` on the `ProjectMember` table. All the data in the column will be lost.
  - You are about to drop the column `otherUrl` on the `ProjectMember` table. All the data in the column will be lost.
  - You are about to drop the column `previousProjects` on the `ProjectMember` table. All the data in the column will be lost.
  - You are about to drop the column `telegram` on the `ProjectMember` table. All the data in the column will be lost.
  - You are about to drop the column `twitter` on the `ProjectMember` table. All the data in the column will be lost.
  - You are about to drop the column `warpcast` on the `ProjectMember` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Project" DROP COLUMN "blog",
DROP COLUMN "communityUrl",
DROP COLUMN "demoUrl",
DROP COLUMN "excerpt",
DROP COLUMN "mirror",
DROP COLUMN "otherUrl",
DROP COLUMN "website";

-- AlterTable
ALTER TABLE "ProjectMember" DROP COLUMN "github",
DROP COLUMN "linkedin",
DROP COLUMN "otherUrl",
DROP COLUMN "previousProjects",
DROP COLUMN "telegram",
DROP COLUMN "twitter",
DROP COLUMN "warpcast";
