import * as  CharmversePrismaClient from "@prisma/client";

export * as CharmversePrismaClient from '@prisma/client';
export type TransactionClient = CharmversePrismaClient.PrismaClient | CharmversePrismaClient.Prisma.TransactionClient;

// Pass a transaction from outer scope of function calling this
export type Transaction = { tx: TransactionClient };
export type OptionalTransaction = Partial<Transaction>;