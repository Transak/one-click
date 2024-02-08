// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Importing required OpenZeppelin contracts
import "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

/**
 * @title TransakMulticallExecuter
 * @dev This contract allows to execute multiple calls in a single transaction and handles ERC721 and ERC1155 tokens.
 */
contract TransakMulticallExecuter is
    Ownable2StepUpgradeable,
    ReentrancyGuardUpgradeable,
    IERC721Receiver,
    IERC1155Receiver
{

   // Interface IDs for ERC165, ERC721 and ERC1155
    bytes4 public constant ERC165_INTERFACE_ID = 0x01ffc9a7;
    bytes4 public constant ERC721_TOKENRECEIVER_INTERFACE_ID = 0x150b7a02;
    bytes4 public constant ERC1155_TOKENRECEIVER_INTERFACE_ID = 0x4e2312e0;

    // Events emitted
    event MulticallExecuted(address[] targets, bytes[] data);
    event NativeTokenReceived(address, uint256);

    // Custom error to be thrown when a call fails
    error CallFailed(address _target, bytes _data);
    error CallFailedWithReason(address _target, bytes _data, string _reason);

    /**
     * @dev Initializes the contract by setting up ownership and reentrancy guard
     */
    function initialize() public initializer {
        __Ownable_init();
        __ReentrancyGuard_init();
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /**
     * @dev This function allows the contract to call multiple external contracts in one transaction.
     * @param targets The addresses of the contracts to call.
     * @param data The calldata to pass to each contract.
     * @param value The amount of Ether to send to each contract.
     * @return results The results of each call.
     */
    function multiCall(
        address[] calldata targets,
        bytes[] calldata data,
        uint256[] calldata value
    ) external payable onlyOwner nonReentrant returns (bytes[] memory) {
        require(reduce(value) <= msg.value,"msg.value should be greater than sum of value[]");
        require(targets.length != 0, "target length is 0");
        require(targets.length == data.length, "target length != data length");
        require(targets.length == value.length, "target length != value length");


        bytes[] memory results = new bytes[](data.length);

        for (uint256 i; i < targets.length; i++) {
            require(targets[i].code.length > 0 || data[i].length == 0, "target account is not a valid contract.if EOA data must be empty");
            (bool success, bytes memory result) = targets[i].call{
                value: value[i]
            }(data[i]);

            if (!success) {
                if (result.length == 0) {
                    revert CallFailed(targets[i], data[i]);
                }
                
                assembly {
                       result := add(result, 0x04)
                }
                revert CallFailedWithReason(targets[i], data[i],abi.decode(result,(string)));
            }
            results[i] = result;
        }

        emit MulticallExecuted(targets, data);
        return results;
    }

    /**
     * @dev This function is a fallback function that is called when the contract receives Ether without any other data.
     * It emits an event `NativeTokenReceived` with the sender's address and the value of Ether received.
     * The function is marked as `external`, meaning it can only be called from other contracts or transactions, and `payable`,
     * which allows it to receive Ether.
     *
     * @notice Any Ether sent to the contract will be received by this function and an event will be emitted.
     */
    receive() external payable {
        emit NativeTokenReceived(msg.sender, msg.value);
    }

    /**
     * @dev This function checks if the contract supports a specific interface.
     * It takes an interface ID as a parameter and checks if it matches any of the supported interface IDs.
     * The function is marked as `external`, meaning it can only be called from other contracts or transactions, and `pure`,
     * which means it does not read from or write to the blockchain state.
     *
     * @param interfaceId The ID of the interface to check.
     * @return _ A boolean indicating whether the contract supports the given interface.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) external pure returns (bool) {
        return
            interfaceId == ERC1155_TOKENRECEIVER_INTERFACE_ID ||
            interfaceId == ERC721_TOKENRECEIVER_INTERFACE_ID ||
            interfaceId == ERC165_INTERFACE_ID;
    }

    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    /**
     * @dev Whenever an {IERC1155} `tokenId` token is transferred to this contract via {IERC1155-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC1155Receiver.onERC1155Received.selector`.
     */
    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return IERC1155Receiver.onERC1155Received.selector;
    }

    /**
     * @dev Whenever an {IERC1155} `tokenId` token is transferred to this contract via {IERC1155-safeBatchTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC1155Receiver.onERC1155BatchReceived.selector`.
     */
    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure override returns (bytes4) {
        return IERC1155Receiver.onERC1155BatchReceived.selector;
    }

    /**
     * @dev This function allows the contract owner to withdraw all Ether from the contract.
     */
    function withdrawEther() external onlyOwner {
        // Transfer the contract's Ether balance to the owner's address
        payable(msg.sender).transfer(address(this).balance);
    }

    /**
     * @dev This function takes an array of unsigned integers as input and returns their sum.
     * It iterates over each element in the array and adds it to the result.
     * The function is marked as `internal`, meaning it can only be called from this contract or contracts that inherit from it.
     * It is also marked as `pure` because it does not read from or write to the blockchain state.
     *
     * @param arr An array of unsigned integers.
     * @return result The sum of all elements in the input array.
     */
    function reduce(
        uint256[] memory arr
    ) internal pure returns (uint256 result) {
        result = 0;
        for (uint256 i = 0; i < arr.length; i++) {
            result += arr[i];
        }

        return result;
    }
}
