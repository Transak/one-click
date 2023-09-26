import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";

import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    hardhat: {},
    imxzkevm: {
      url: process.env.RPC_IMX,
      accounts: [process.env.PRIVATE_KEY as string],
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
    arbitrum_goerli: {
      url: "https://endpoints.omniatech.io/v1/arbitrum/goerli/public",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    optimism_goerli: {
      url: "https://optimism-goerli.publicnode.com",
      accounts: [process.env.PRIVATE_KEY as string],
    },
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
