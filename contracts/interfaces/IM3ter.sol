// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "@openzeppelin/contracts@5.0.2/interfaces/IERC721.sol";

interface IM3ter is IERC721 {
    event Register(
        uint256 indexed tokenId,
        uint256 indexed publicKey,
        string indexed arweaveTag,
        uint256 timestamp,
        address from
    );

    struct Attribute {
        uint256 publicKey;
        string arweaveTag;
    }

    function safeMint(address to, string memory uri) external;

    function _register(
        uint256 tokenId,
        uint256 publicKey,
        string calldata arweaveTag
    ) external;
}
