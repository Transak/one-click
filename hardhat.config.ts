import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";

import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    hardhat: {},
    imxzkevm: {
      url: "https://rpc.testnet.immutable.com",
      accounts: [process.env.PRIVATE_KEY as string],
      gasPrice: 100000000000 ,
      
    },
    goerli: {
      url: process.env.RPC_GOERLI,
      accounts: [process.env.PRIVATE_KEY as string],
    },
    polygon_mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    bnb: {
      url: "https://endpoints.omniatech.io/v1/bsc/testnet/public",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    arbitrum_sepolia: {
      url: "https://sepolia-rollup.arbitrum.io/rpc",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    optimism_goerli: {
      url: "https://optimism-goerli.publicnode.com",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    eth_mainnet: {
      url: "https://ethereum.publicnode.com",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    polygon_mainnet: {
      url: "https://endpoints.omniatech.io/v1/matic/mainnet/public",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    sepolia: {
      url: "https://ethereum-sepolia.publicnode.com",
      accounts: [process.env.PRIVATE_KEY as string],

    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API,
    customChains: [
      {
        network: "imxzkevm",
        chainId: 13472,
        urls: {
          apiURL: "",
          browserURL: "https://explorer.testnet.immutable.com",
        },
      },
    ],
  },
};

export default config;
