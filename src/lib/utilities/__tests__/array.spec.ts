import { asyncSeries } from '../array';

describe('Async utils', () => {
  it('asyncSeries() returns resolved promises', async () => {
    return asyncSeries([1, 2, 3], (num) => Promise.resolve(num + 1)).then((result) => {
      expect(result).toEqual([2, 3, 4]);
    });
  });

  it('asyncSeries() throws an error', async () => {
    await expect(asyncSeries([1, 2, 3], () => Promise.reject('foo_error'))).rejects.toEqual('foo_error');
  });
});
