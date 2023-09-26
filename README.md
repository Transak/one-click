# one-click

### TransakMulticallExecuter

The contract to call multiple external contracts in one transaction.
This Contract uses TransparentUpgradeableProxy.

## Functions

### initialize

```solidity
    function initialize(address _owner) public initializer
```

This function is called to initialize the contract

### multiCall

```solidity

function multiCall(
         calldata targets,
        bytes[] calldata data
    ) external onlyOwner nonReentrant returns (bytes[] memory)
```

Batchs multiple transactions in one transaction.

Parameters

| First Header | Type      | Second Header                                          |
| ------------ | --------- | ------------------------------------------------------ |
| `targets`    | address[] | Array of address of Smartcontracts                     |
| `data`       | bytes[]   | Array of call data to be executed on the smartcontract |

### onERC721Received

```solidity

function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4)
```

ERC721 callback function to receive NFTs.

When using the `safeTransferFrom` function to send ERC721 tokens to a contract address, it will fail unless the receiving contract properly implements the ERC721TokenReceiver interface. (See the ERC721 Standard for details).

the `onERC721Received` function and will return bytes4(keccak256("onERC721Received(address,uint256,bytes)")).

## Events

```solidity
   event MulticallExecuted(address[] targets, bytes[] data);

```

emits an event with params when the `multiCall` function is executed.

## Errors

```solidity
    error CallFailed(address _target, bytes _data);
```

Error thrown when the call to the external contract fails.

## Local Development

### Install Dependencies

`yarn`

### Compile Contracts

`yarn compile`

### Flatten Contract

`yarn flatten`

### Deploy Contracts

`yarn deploy`

# Deployed Contract Address

| Network                | Address                                      | Links                                                                                     |
| ---------------------- | -------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Goerli                 | `0xe4E30Bcb733cE466a768E924FF0E458118A2555C` | https://goerli.etherscan.io/address/0x53F9a8F282ee39169CDB0851aA768c35A72Fe0e9            |
| ImmutableZKEvm-testnet | `0x92B676D4cAF95C07e33866d6e8CB40e65177f88A` | https://explorer.testnet.immutable.com/address/0x92B676D4cAF95C07e33866d6e8CB40e65177f88A |
| Polygon-mumbai         | `0x08217aa0394c637013f0b4fbc3a29e44c67062e7` | https://mumbai.polygonscan.com/address/0x08217aa0394c637013f0b4fbc3a29e44c67062e7         |
| Bsc-testnet            | `0x0E9539455944BE8a307bc43B0a046613a1aD6732` | https://testnet.bscscan.com/address/0x0E9539455944BE8a307bc43B0a046613a1aD6732            |
| Arbitrum-goerli        | `0x0E9539455944BE8a307bc43B0a046613a1aD6732` | https://goerli.arbiscan.io/address/0x0E9539455944BE8a307bc43B0a046613a1aD6732             |
| Optimism-goerli        | `0x0E9539455944BE8a307bc43B0a046613a1aD6732` | https://goerli-optimism.etherscan.io/address/0x0e9539455944be8a307bc43b0a046613a1ad6732   |
