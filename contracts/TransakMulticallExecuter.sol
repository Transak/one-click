// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

contract TransakMulticallExecuter is
    OwnableUpgradeable,
    ReentrancyGuardUpgradeable,
    IERC721Receiver,
    IERC1155Receiver
{
    bytes4 public constant ERC165_INTERFACE_ID = 0x01ffc9a7;
    bytes4 public constant ERC721_TOKENRECEIVER_INTERFACE_ID = 0x150b7a02;
    bytes4 public constant ERC1155_TOKENRECEIVER_INTERFACE_ID = 0x4e2312e0;

    event MulticallExecuted(address[] targets, bytes[] data);
    event NativeTokenReceived(address, uint256);

    error CallFailed(address _target, bytes _data);

    // @dev This function is called to initialize the contract
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
     * @return results The results of each call.
     */
    function multiCall(
        address[] calldata targets,
        bytes[] calldata data,
        uint256[] calldata value
    ) external payable onlyOwner nonReentrant returns (bytes[] memory) {
        require(
            reduce(value) >= msg.value,
            "msg.value should be greater than sum of value[]"
        );

        require(targets.length != 0, "target length is 0");
        require(targets.length == data.length, "target length != data length");

        bytes[] memory results = new bytes[](data.length);

        for (uint256 i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].call{
                value: value[i]
            }(data[i]);

            if (!success) {
                if (result.length == 0) {
                    revert CallFailed(targets[i], data[i]);
                }
                assembly {
                    revert(add(result, 32), mload(result))
                }
            }
            results[i] = result;
        }

        emit MulticallExecuted(targets, data);
        return results;
    }

    receive() external payable {
        emit NativeTokenReceived(msg.sender, msg.value);
    }

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
        return this.onERC1155Received.selector;
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
        return this.onERC1155BatchReceived.selector;
    }

    // utils
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
