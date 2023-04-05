import {PrismaClient} from '@prisma/client';

// @ts-expect-error - dont mutate global for Node.js
export const prisma: PrismaClient = global.prisma || new PrismaClient({});

// remember this instance of prisma in development to avoid too many clients
if (process.env.NODE_ENV === 'development') {
  // @ts-expect-error
  global.prisma = prisma;
}

