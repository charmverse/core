/* eslint-disable no-console */
import type { Page, Prisma } from '@prisma/client';

import type { OptionalPrismaTransaction } from '../../prisma-client';
import { prisma } from '../../prisma-client';
import { InvalidInputError, PageNotFoundError } from '../errors';

import type {
  PageNodeWithPermissions,
  PageTreeResolveInput,
  TargetPageTree,
  TargetPageTreeWithFlatChildren,
  PageWithPermissions
} from './interfaces';
import { flattenTree, mapTargetPageTree } from './mapPageTree';

function generatePagesQuery({
  includeDeletedPages,
  fullPage,
  pageIds,
  spaceId
}: {
  includeDeletedPages?: boolean;
  fullPage?: boolean;
  pageIds?: string[];
  spaceId?: string;
}) {
  if (!pageIds && !spaceId) {
    throw new InvalidInputError(`1 of spaceId or pageIds is required`);
  }

  const pageQueryContent: Partial<Prisma.PageFindManyArgs> = fullPage
    ? {
        include: {
          permissions: {
            include: {
              sourcePermission: true
            }
          }
        }
      }
    : {
        select: {
          id: true,
          parentId: true,
          boardId: true,
          cardId: true,
          index: true,
          type: true,
          createdAt: true,
          deletedAt: true,
          permissions: {
            include: {
              sourcePermission: true
            }
          }
        }
      };

  return {
    where: {
      spaceId,
      id: {
        in: pageIds
      },
      // Soft deleted pages have a value for deletedAt. Active pages are null
      deletedAt: includeDeletedPages ? undefined : null
    },
    ...pageQueryContent
  };
}

/**
 * Returns resolved page tree along with the permissions state
 *
 * Parents is an ordered array from closest ancestor up to the root
 * Children is a recursive array of children in tree format
 *
 * Pass flatten children prop to also receive a flat array of children
 */
// Normal page node
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage
}: PageTreeResolveInput & {
  flattenChildren?: undefined | false;
  fullPage?: false | undefined;
} & OptionalPrismaTransaction): Promise<TargetPageTree<PageNodeWithPermissions>>;
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage
}: PageTreeResolveInput & { flattenChildren: true; fullPage?: false | undefined } & OptionalPrismaTransaction): Promise<
  TargetPageTreeWithFlatChildren<PageNodeWithPermissions>
>;
// Full pages
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage
}: PageTreeResolveInput & { flattenChildren?: undefined | false; fullPage: true } & OptionalPrismaTransaction): Promise<
  TargetPageTree<PageWithPermissions>
>;
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage
}: PageTreeResolveInput & { flattenChildren: true; fullPage: true } & OptionalPrismaTransaction): Promise<
  TargetPageTreeWithFlatChildren<PageWithPermissions>
>;
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren = false,
  includeDeletedPages = false,
  fullPage,
  tx = prisma
}: PageTreeResolveInput & OptionalPrismaTransaction): Promise<
  TargetPageTree<PageNodeWithPermissions> | TargetPageTreeWithFlatChildren<PageNodeWithPermissions>
> {
  const pageWithSpaceIdOnly = await tx.page.findUnique({
    where: {
      id: pageId
    },
    select: {
      spaceId: true
    }
  });

  if (!pageWithSpaceIdOnly) {
    throw new PageNotFoundError(pageId);
  }

  console.time('PRISMA');

  const pagesTreeIds = (await tx.$queryRaw`WITH RECURSIVE parents_cte AS (
    SELECT id, "parentId"
    FROM "Page"
    WHERE id = ${pageId}::UUID
    
    UNION ALL
    
    SELECT p.id, p."parentId"
    FROM "Page" p
    INNER JOIN parents_cte ON p.id = parents_cte."parentId"
  ), children_cte AS (
    SELECT id, "parentId"
    FROM "Page"
    WHERE id = ${pageId}::UUID
    
    UNION ALL
    
    SELECT p.id, p."parentId"
    FROM "Page" p
    INNER JOIN children_cte ON p."parentId" = children_cte.id
  )
  SELECT id FROM parents_cte 
  UNION 
  SELECT id FROM children_cte;
`) as Pick<Page, 'id'>[];

  const pagesInSpace = (await tx.page.findMany(
    generatePagesQuery({
      includeDeletedPages,
      pageIds: pagesTreeIds?.map((p) => p.id) ?? [],
      fullPage
    })
  )) as PageNodeWithPermissions[] | PageWithPermissions[];

  console.timeEnd('PRISMA');

  console.time('MAP');

  const { parents, targetPage } = mapTargetPageTree({
    items: pagesInSpace,
    targetPageId: pageId,
    includeDeletedPages
  });
  console.timeEnd('MAP');

  // Prune the parent references so we have a direct chain
  for (let i = 0; i < parents.length; i++) {
    const parent = parents[i];

    parent.children = parent.children.filter((child) => {
      if (i === 0) {
        return child.id === targetPage.id;
      }

      // The previous item in the parents array is the child of the current parent node
      return child.id === parents[i - 1].id;
    });
  }

  return {
    parents,
    targetPage,
    flatChildren: flattenChildren ? flattenTree(targetPage) : undefined
  } as any;
}

export type MultiPageTreeResolveInput<F extends boolean | undefined = boolean> = Pick<
  PageTreeResolveInput,
  'includeDeletedPages' | 'fullPage'
> & { pageIds: string[]; flattenChildren?: F };

/**
 * Resolved page trees mapped to the page id
 * @F Whether to have the flat children
 */
export type MultiPageTreeResolveOutput<F extends boolean | undefined = false> = Record<
  string,
  | (F extends true ? TargetPageTreeWithFlatChildren<PageNodeWithPermissions> : TargetPageTree<PageNodeWithPermissions>)
  | null
>;

export async function multiResolvePageTree({
  pageIds,
  includeDeletedPages,
  flattenChildren,
  fullPage
}: MultiPageTreeResolveInput<false | undefined>): Promise<MultiPageTreeResolveOutput<false | undefined>>;
export async function multiResolvePageTree({
  pageIds,
  includeDeletedPages,
  flattenChildren,
  fullPage
}: MultiPageTreeResolveInput<true>): Promise<MultiPageTreeResolveOutput<true>>;
export async function multiResolvePageTree<F extends boolean | undefined>({
  pageIds,
  includeDeletedPages,
  flattenChildren,
  fullPage,
  tx = prisma
}: MultiPageTreeResolveInput<F> & OptionalPrismaTransaction): Promise<MultiPageTreeResolveOutput<F>> {
  const pagesWithSpaceIds = (
    await tx.page.findMany({
      where: {
        id: {
          in: pageIds
        }
      },
      select: {
        id: true,
        spaceId: true
      }
    })
  ).map((p) => p.spaceId);

  const uniqueSpaceIds = [...new Set(pagesWithSpaceIds)];

  if (uniqueSpaceIds.length > 1) {
    throw new InvalidInputError('All pages must be in the same space');
  } else if (uniqueSpaceIds.length === 0) {
    return {};
  }

  const spaceId = uniqueSpaceIds[0];

  const pagesInSpace = (await tx.page.findMany(
    generatePagesQuery({
      includeDeletedPages,
      spaceId
    })
  )) as PageNodeWithPermissions[] | PageWithPermissions[];

  const mappedResults = await Promise.all(
    pageIds.map((id) =>
      resolvePageTreeAlt({
        pageId: id,
        flattenChildren: flattenChildren as any,
        includeDeletedPages,
        fullPage: fullPage as any,
        pageNodes: pagesInSpace,
        tx
      }).catch(() => null)
    )
  );

  return pageIds.reduce((acc, id, index) => {
    acc[id] = mappedResults[index] as any;

    return acc;
  }, {} as MultiPageTreeResolveOutput<F>);
}
