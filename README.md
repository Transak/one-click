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

| Network          | Address                                                                                                                                             | Verified |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| Goerli           | Contract `0x53F9a8F282ee39169CDB0851aA768c35A72Fe0e9` Proxy: `0xe4E30Bcb733cE466a768E924FF0E458118A2555C` https://goerli.etherscan.io/address/0x53F9a8F282ee39169CDB0851aA768c35A72Fe0e9#code                    | true     |
| Immutable ZK Evm | `0x962D7be55A4d39b61c04Cf5ADe72D8eE275A7bCB` https://explorer.testnet.immutable.com/address/0x962D7be55A4d39b61c04Cf5ADe72D8eE275A7bCB?tab=contract | false    |



