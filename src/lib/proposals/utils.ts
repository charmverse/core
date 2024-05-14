import type { ProposalEvaluation, ProposalEvaluationType } from '@prisma/client';
import sortBy from 'lodash/sortBy';

/**
 * find the first evalation that does not have a result
 *
 * */
export function getCurrentEvaluation<
  T extends Pick<ProposalEvaluation, 'index' | 'result'> = Pick<ProposalEvaluation, 'index' | 'result'>
>(evaluations: T[]): T | undefined {
  const sortedEvaluations = sortBy(evaluations, 'index');
  const currentEvaluation = sortedEvaluations.find((evaluation) => evaluation.result === 'fail' || !evaluation.result);

  return currentEvaluation ?? sortedEvaluations[sortedEvaluations.length - 1];
}

export const privateEvaluationSteps: ProposalEvaluationType[] = ['rubric', 'pass_fail', 'vote'];
