import { InvalidInputError } from '../errors';

export function generateCategoryIdQuery(categoryIds?: string | string[]): { in: string[] } | undefined {
  if (!categoryIds) {
    return undefined;
  }
  if (categoryIds && !Array.isArray(categoryIds) && typeof categoryIds !== 'string') {
    throw new InvalidInputError(`Cannot get accessible categories with an invalid category id.`);
  }

  return {
    in: typeof categoryIds === 'string' ? [categoryIds] : categoryIds
  };
}
