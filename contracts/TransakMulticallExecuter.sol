// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract TransakMulticallExecuter is Ownable, ReentrancyGuard, IERC721Receiver {
    event MulticallExecuted(address[] targets, bytes[] data);
    error CallFailed(address _target, bytes _data);

    // multi call executer
    function multiCall(address[] calldata targets, bytes[] calldata data)
        external
        onlyOwner
        nonReentrant
        returns (bytes[] memory)
    {
        require(targets.length != 0, "target length is 0");
        require(targets.length == data.length, "target length != data length");

        bytes[] memory results = new bytes[](data.length);

        for (uint256 i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].call(data[i]);

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
}
