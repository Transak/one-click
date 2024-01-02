const { ethers, upgrades } = require("hardhat");

async function main() {
  const PROXY_ADDRESS = "0x08217aa0394c637013f0b4fbc3a29e44c67062e7";

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
