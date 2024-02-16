const { ethers, upgrades } = require("hardhat");

async function main() {
  const PROXY_ADDRESS = "0x4A598B7eC77b1562AD0dF7dc64a162695cE4c78A";
  // forceImport is used to force the import of the contract if it is not present in .openzeppelin folder
  const forceImport = false;

  const TransakMulticallExecuter = await ethers.getContractFactory(
    "TransakMulticallExecuter"
  );

  if (forceImport) {
    await upgrades.forceImport(PROXY_ADDRESS, TransakMulticallExecuter);
    console.log("TransakMulticallExecuter imported");
  }

  const transakMulticallExecuter = await upgrades.upgradeProxy(
    PROXY_ADDRESS,
    TransakMulticallExecuter,
    {
      redeployImplementation: "always",
    }
  );
  console.log(
    "TransakMulticallExecuter upgraded",
    await transakMulticallExecuter.getAddress()
  );
}

main();
