import { getCurrentEvaluation } from '../utils';

describe('getCurrentEvaluation()', () => {
  it('should return the current evaluation that does not yet have a result', () => {
    const result = getCurrentEvaluation([
      { index: 3, result: null, appealedAt: null },
      { index: 1, result: 'pass', appealedAt: null },
      { index: 2, result: null, appealedAt: null },
      { index: 0, result: 'pass', appealedAt: null }
    ]);

    expect(result?.index).toBe(2);
  });

  it('should stop at an evaluation which is marked as failed', () => {
    const result = getCurrentEvaluation([
      { index: 3, result: null, appealedAt: null },
      { index: 1, result: 'pass', appealedAt: null },
      { index: 2, result: 'fail', appealedAt: null },
      { index: 0, result: 'pass', appealedAt: null }
    ]);

    expect(result?.index).toBe(2);
  });

  it('should stop at an final step evaluation if its marked as passed', () => {
    const result = getCurrentEvaluation([
      { index: 0, result: 'pass', appealedAt: null },
      { index: 1, result: 'pass', finalStep: true, appealedAt: null },
      { index: 3, result: null, appealedAt: null },
      { index: 2, result: null, appealedAt: null }
    ]);

    expect(result?.index).toBe(1);
  });

  it('should return the final evaluation if all evaluations passed', () => {
    const result = getCurrentEvaluation([
      { index: 3, result: 'pass', appealedAt: null },
      { index: 1, result: 'pass', appealedAt: null },
      { index: 2, result: 'pass', appealedAt: null },
      { index: 0, result: 'pass', appealedAt: null }
    ]);

    expect(result?.index).toBe(3);
  });
});
