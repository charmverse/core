import type { Page, Prisma, PrismaPromise } from '../../prisma';
import { prisma } from '../../prisma-client';

export function generatePage<T>({ data, include }: Prisma.PageCreateArgs): PrismaPromise<Page & T> {
  const createArgs: Prisma.PageCreateArgs = {
    data
  };

  const includeData =
    typeof include !== undefined
      ? include
      : {
          permissions: {
            include: {
              sourcePermission: true
            }
          }
        };

  createArgs.include = includeData;

  return prisma.page.create(createArgs) as unknown as PrismaPromise<Page & T>;
}
