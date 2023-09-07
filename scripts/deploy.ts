import { ethers } from "hardhat";

async function main() {
  const transakMulticallExecuter = await ethers.deployContract(
    "TransakMulticallExecuter"
  );

  await transakMulticallExecuter.waitForDeployment();

  console.log(
    `TransakMulticallExecuter deployed to ${transakMulticallExecuter.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
