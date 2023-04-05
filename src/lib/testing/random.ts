import { Wallet } from "ethers";



export function randomETHWalletAddress() {
    return Wallet.createRandom().address.toLowerCase();
  }