import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

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
