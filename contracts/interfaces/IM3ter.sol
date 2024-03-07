// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts@4.9.3/token/ERC721/IERC721.sol";

interface IM3ter is IERC721 {
    error NonexistentM3ter();

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

    function mint(address to) external;

    function exists(uint256 tokenId) external returns (bool);

    function _register(
        uint256 tokenId,
        uint256 publicKey,
        string calldata arweaveTag
    ) external;
}
