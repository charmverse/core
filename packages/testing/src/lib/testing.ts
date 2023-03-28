import { Wallet, SigningKey, randomBytes } from 'ethers';

export function randomETHWalletAddress() {
  const key = new SigningKey(randomBytes(32));
  return new Wallet(key).address.toLowerCase();
}
