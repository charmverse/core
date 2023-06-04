/* eslint-disable no-console */
import type { Prisma } from '@prisma/client';

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
  spaceId,
  includeDeletedPages,
  fullPage
}: {
  spaceId: string;
  includeDeletedPages?: boolean;
  fullPage?: boolean;
}) {
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
  fullPage,
  pageNodes
}: PageTreeResolveInput & {
  flattenChildren?: undefined | false;
  fullPage?: false | undefined;
} & OptionalPrismaTransaction): Promise<TargetPageTree<PageNodeWithPermissions>>;
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage,
  pageNodes
}: PageTreeResolveInput & { flattenChildren: true; fullPage?: false | undefined } & OptionalPrismaTransaction): Promise<
  TargetPageTreeWithFlatChildren<PageNodeWithPermissions>
>;
// Full pages
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage,
  pageNodes
}: PageTreeResolveInput & { flattenChildren?: undefined | false; fullPage: true } & OptionalPrismaTransaction): Promise<
  TargetPageTree<PageWithPermissions>
>;
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren,
  fullPage,
  pageNodes
}: PageTreeResolveInput & { flattenChildren: true; fullPage: true } & OptionalPrismaTransaction): Promise<
  TargetPageTreeWithFlatChildren<PageWithPermissions>
>;
export async function resolvePageTreeAlt({
  pageId,
  flattenChildren = false,
  includeDeletedPages = false,
  fullPage,
  pageNodes,
  tx = prisma
}: PageTreeResolveInput & OptionalPrismaTransaction): Promise<
  TargetPageTree<PageNodeWithPermissions> | TargetPageTreeWithFlatChildren<PageNodeWithPermissions>
> {
  const pageWithSpaceIdOnly = pageNodes
    ? pageNodes.find((node) => node.id === pageId)
    : await tx.page.findUnique({
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

  // const pagesInSpace = (pageNodes ??
  //   (await tx.page.findMany(
  //     generatePagesQuery({
  //       includeDeletedPages,
  //       spaceId: pageWithSpaceIdOnly.spaceId,
  //       fullPage
  //     })
  //   ))) as PageNodeWithPermissions[] | PageWithPermissions[];

  const pagesTreeIds = (await prisma.$queryRaw`WITH RECURSIVE parents_cte AS (
    SELECT id, "parentId", title
    FROM "Page"
    WHERE id = ${pageId}::UUID
    
    UNION ALL
    
    SELECT p.id, p."parentId", p.title
    FROM "Page" p
    INNER JOIN parents_cte ON p.id = parents_cte."parentId"
  ), children_cte AS (
    SELECT id, "parentId", title
    FROM "Page"
    WHERE id = ${pageId}::UUID
    
    UNION ALL
    
    SELECT p.id, p."parentId", p.title
    FROM "Page" p
    INNER JOIN children_cte ON p."parentId" = children_cte.id
  )
  SELECT 'parent' as type, id, "parentId", title FROM parents_cte 
  UNION 
  SELECT 'child' as type, id, "parentId", title FROM children_cte;
`) as any;

  console.log(pagesTreeIds);

  console.timeEnd('PRISMA');

  console.time('MAP');

  const { parents, targetPage } = mapTargetPageTree({
    items: pagesTreeIds,
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
