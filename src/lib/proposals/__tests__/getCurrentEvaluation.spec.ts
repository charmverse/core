import { getCurrentEvaluation } from '../utils';

describe('getCurrentEvaluation()', () => {
  it('should return the current evaluation that does not yet have a result', () => {
    const result = getCurrentEvaluation([
      { index: 3, result: null },
      { index: 1, result: 'pass' },
      { index: 2, result: null },
      { index: 0, result: 'pass' }
    ]);

    expect(result.index).toBe(2);
  });

  it('should stop at an evaluation which is marked as failed', () => {
    const result = getCurrentEvaluation([
      { index: 3, result: null },
      { index: 1, result: 'pass' },
      { index: 2, result: 'fail' },
      { index: 0, result: 'pass' }
    ]);

    expect(result.index).toBe(2);
  });

  it('should return the final evaluation if all evaluations passed', () => {
    const result = getCurrentEvaluation([
      { index: 3, result: 'pass' },
      { index: 1, result: 'pass' },
      { index: 2, result: 'pass' },
      { index: 0, result: 'pass' }
    ]);

    expect(result.index).toBe(3);
  });
});
