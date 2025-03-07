-- CreateTable
CREATE TABLE "ScoutFarcasterNotification" (
    "id" UUID NOT NULL,
    "fid" INTEGER NOT NULL,
    "userId" UUID NOT NULL,
    "notificationType" TEXT NOT NULL,
    "templateVariables" JSONB NOT NULL DEFAULT '{}',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScoutFarcasterNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoutEmailNotification" (
    "id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "templateVariables" JSONB NOT NULL,
    "userId" UUID NOT NULL,
    "notificationType" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScoutEmailNotification_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ScoutFarcasterNotification" ADD CONSTRAINT "ScoutFarcasterNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoutEmailNotification" ADD CONSTRAINT "ScoutEmailNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Scout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
