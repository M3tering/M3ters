// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts@4.9.3/utils/Counters.sol";
import "./interfaces/IM3ter.sol";
import "./XRC721.sol";

/// @custom:security-contact info@whynotswitch.com
contract M3ter is XRC721, IM3ter {
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => Attribute) public attributes;

    constructor() ERC721("M3ter", "M3R") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(REGISTRAR_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _tokenIdCounter.increment();
    }

    function mint(address to) external onlyRole(REGISTRAR_ROLE) whenNotPaused {
        _safeMint(to, _tokenIdCounter.current());
        _tokenIdCounter.increment();
    }

    function exists(uint256 tokenId) external view returns (bool) {
        return _exists(tokenId);
    }

    function _register(
        uint256 tokenId,
        uint256 publicKey,
        string calldata arweaveTag
    ) external onlyRole(REGISTRAR_ROLE) {
        if (!_exists(tokenId)) revert NonexistentM3ter();
        attributes[tokenId] = Attribute(publicKey, arweaveTag);
        emit Register(
            tokenId,
            publicKey,
            arweaveTag,
            block.timestamp,
            msg.sender
        );
    }
}
