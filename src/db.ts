import { PrismaClient } from '@prisma/client';

declare global {
  // eslint-disable-next-line no-var, vars-on-top
  var prisma: PrismaClient;
}

export const prisma: PrismaClient = global.prisma || new PrismaClient();

// remember this instance of prisma in development to avoid too many clients
if (process.env.NODE_ENV === 'development') {
  global.prisma = prisma;
}
