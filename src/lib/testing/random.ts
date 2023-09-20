import { generatePrivateKey, privateKeyToAccount } from 'viem/accounts';

export function randomETHWalletAddress(privateKey?: ReturnType<typeof generatePrivateKey>) {
  return randomETHWallet(privateKey).address;
}

export function randomETHWallet(privateKey = generatePrivateKey()) {
  return privateKeyToAccount(privateKey);
}
