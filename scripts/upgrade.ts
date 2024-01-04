const { ethers, upgrades } = require("hardhat");

async function main() {
  const PROXY_ADDRESS = "0x489F56e3144FF03A887305839bBCD20FF767d3d1";
  // forceImport is used to force the import of the contract if it is not present in .openzeppelin folder
  const forceImport = false;

  const TransakMulticallExecuter = await ethers.getContractFactory(
    "TransakMulticallExecuter"
  );

  // if (true) {
  //   await upgrades.forceImport(PROXY_ADDRESS, TransakMulticallExecuter);
  //   console.log("TransakMulticallExecuter imported");
  // }

  const transakMulticallExecuter = await upgrades.upgradeProxy(
    PROXY_ADDRESS,
    TransakMulticallExecuter
  );
  console.log("TransakMulticallExecuter upgraded",await  transakMulticallExecuter.getAddress());
}

main();
