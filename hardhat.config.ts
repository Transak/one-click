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
      url: "https://rpc.sepolia.org",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    cronos_mainnet: {
      url: "https://rpc.ebisusbay.com/",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    chiliz_spicy: {
      url: "https://spicy-rpc.chiliz.com/",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    chillz_mainnet: {
      url: "https://rpc.ankr.com/chiliz ",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    base_testnet: {
      url: "https://base-sepolia-rpc.publicnode.com",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    base_mainnet: {
      url: "https://base.llamarpc.com",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    ronin_testnet: {
      url: "https://saigon-testnet.roninchain.com/rpc",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    ronin_mainnet: {
      url: "https://api.roninchain.com/rpc",
      // accounts: [
      //   "",
      // ],
      chainId: 2020,
      gasPrice: 20_000_000_000,
    },
  },
  // etherscan: {
  //   apiKey: {
  //     chiliz_spicy: "chiliz_spicy", // apiKey is not required, just set a placeholder
  //     base: "9S1T4PB5P8ASSVYMS7HJRCARJY4PEIKWU2",
  //   },
  //   customChains: [
  //     {
  //       network: "chiliz_spicy",
  //       chainId: 88882,
  //       urls: {
  //         apiURL:
  //           "https://api.routescan.io/v2/network/testnet/evm/88882/etherscan",
  //         browserURL: "https://testnet.chiliscan.com",
  //       },
  //     },
  //   ],
  // },
};

export default config;
