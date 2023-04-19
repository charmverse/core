import type { Prisma } from '@prisma/client';
import { PrismaClient } from '@prisma/client';

declare global {
  // eslint-disable-next-line no-var, vars-on-top
  var prisma: PrismaClient;
}

export const prisma: PrismaClient = global.prisma || new PrismaClient();

// remember this instance of prisma in development to avoid too many clients
if (process.env.NODE_ENV === 'development' || process.env.NODE_ENV === 'test') {
  global.prisma = prisma;
}
export type TransactionClient = PrismaClient | Prisma.TransactionClient;

// Pass a transaction from outer scope of function calling this
export type Transaction = { tx: TransactionClient };
export type OptionalTransaction = Partial<Transaction>;
