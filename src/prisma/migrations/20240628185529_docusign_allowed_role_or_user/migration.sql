-- CreateTable
CREATE TABLE "DocusignAllowedRoleOrUser" (
    "id" UUID NOT NULL,
    "spaceId" UUID NOT NULL,
    "roleId" UUID,
    "userId" UUID,

    CONSTRAINT "DocusignAllowedRoleOrUser_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "DocusignAllowedRoleOrUser" ADD CONSTRAINT "DocusignAllowedRoleOrUser_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocusignAllowedRoleOrUser" ADD CONSTRAINT "DocusignAllowedRoleOrUser_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocusignAllowedRoleOrUser" ADD CONSTRAINT "DocusignAllowedRoleOrUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
