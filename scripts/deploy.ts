import { ethers, upgrades } from "hardhat";

async function main() {
  const TransakMulticallExecuter = await ethers.getContractFactory(
    "TransakMulticallExecuter"
  );

  const transakMulticallExecuter = await upgrades.deployProxy(
    TransakMulticallExecuter,
    {
      initializer: "initialize",
    }
  );

  await transakMulticallExecuter.waitForDeployment();

  console.log(
    `TransakMulticallExecuter deployed to ${await transakMulticallExecuter.getAddress()}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
