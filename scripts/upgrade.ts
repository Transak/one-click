const { ethers, upgrades } = require("hardhat");

async function main() {
  const PROXY_ADDRESS = "0xe4E30Bcb733cE466a768E924FF0E458118A2555C";

  const TransakMulticallExecuter = await ethers.getContractFactory(
    "TransakMulticallExecuter"
  );
  const transakMulticallExecuter = await upgrades.upgradeProxy(
    PROXY_ADDRESS,
    TransakMulticallExecuter
  );
  console.log("TransakMulticallExecuter upgraded");
}

main();
