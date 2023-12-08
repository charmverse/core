import type { ProposalEvaluation } from '@prisma/client';
import sortBy from 'lodash/sortBy';

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

/**
 * find the first evalation that does not have a result
 *
 * */
export function getCurrentEvaluation<
  T extends Pick<ProposalEvaluation, 'index' | 'result'> = Pick<ProposalEvaluation, 'index' | 'result'>
>(evaluations: T[]): T {
  const sortedEvaluations = sortBy(evaluations, 'index');
  const currentEvaluation = sortedEvaluations.find((evaluation) => evaluation.result === 'fail' || !evaluation.result);

  return currentEvaluation ?? sortedEvaluations[sortedEvaluations.length - 1];
}
