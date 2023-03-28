import { isAddress } from 'ethers';

import { randomETHWalletAddress } from './testing';

describe('randomETHWalletAddress', () => {
  it('should generate a random Ethereum Wallet address', () => {
    const randomWalletAddress = randomETHWalletAddress();
    expect(isAddress(randomWalletAddress)).toBe(true);

    const secondRandomWalletAddress = randomETHWalletAddress();
    expect(secondRandomWalletAddress).not.toBe(randomWalletAddress);
  });
});
