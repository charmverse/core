import { Prisma, PrismaClient } from "@prisma/client";

export type TransactionClient = PrismaClient | Prisma.TransactionClient;

// Pass a transaction from outer scope of function calling this
export type Transaction = { tx: TransactionClient };
export type OptionalTransaction = Partial<Transaction>;