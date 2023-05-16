import type { Prisma } from '@prisma/client';
import { PrismaClient } from '@prisma/client';

export * from '@prisma/client';

// @ts-ignore - add support for JSON for BigInt (used in telegramuser) - https://github.com/GoogleChromeLabs/jsbi/issues/30
// eslint-disable-next-line no-extend-native
BigInt.prototype.toJSON = function () {
  return this.toString();
};
export const prisma: PrismaClient = (globalThis as any).prisma || new PrismaClient();

// remember this instance of prisma in development to avoid too many clients
if (process.env.NODE_ENV === 'development' || process.env.NODE_ENV === 'test') {
  (global as any).prisma = prisma;
}
export type PrismaTransactionClient = PrismaClient | Prisma.TransactionClient;

// Pass a transaction from outer scope of function calling this
export type PrismaTransaction = { tx: PrismaTransactionClient };
export type OptionalPrismaTransaction = Partial<PrismaTransaction>;
