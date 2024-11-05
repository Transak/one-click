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
      gasPrice: 100000000000,
    },
    goerli: {
      url: process.env.RPC_GOERLI,
      accounts: [process.env.PRIVATE_KEY as string],
    },
    polygon_mumbai: {
      url: "https://polygon-mumbai-pokt.nodies.app",
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
    optimism_sepolia: {
      url: "https://sepolia.optimism.io",
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
      url: "https://rpc.sepolia.org",
      accounts: [process.env.PRIVATE_KEY as string],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API,
    customChains: [
      {
        network: "optimismSepolia",
        chainId: 11155420,
        urls: {
          apiURL: "https://api-sepolia-optimistic.etherscan.io/api",
          browserURL: "https://sepolia-optimism.etherscan.io/",
        },
      },
      {
        network: "imxzkevm",
        chainId: 13472,
        urls: {
          apiURL: "",
          browserURL: "https://explorer.testnet.immutable.com",
        },
      },
      {
        network: "cronos",
        chainId: 25,
        urls: {
          apiURL: "https://api.cronoscan.com/api",
          browserURL: "https://cronoscan.com/",
        },
      },
      {
        network: "cronosTestnet",
        chainId: 338,
        urls: {
          apiURL: "https://cronos.org/explorer/testnet3/api",
          browserURL: "https://cronos.org/explorer/testnet3/",
        },
      },
    ],
  },
};

export default config;
