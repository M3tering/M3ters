// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./interfaces/IM3ter.sol";
import "./XRC721.sol";

/// @custom:security-contact info@whynotswitch.com
contract M3ter is XRC721, IM3ter {
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");
    uint256 private _nextTokenId;

    mapping(uint256 => Attribute) public attributes;

    constructor() ERC721("M3ter", "M3R") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(REGISTRAR_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    function safeMint(
        address to,
        string memory uri
    ) public onlyRole(REGISTRAR_ROLE) whenNotPaused {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function _register(
        uint256 tokenId,
        uint256 publicKey,
        string calldata arweaveTag
    ) external onlyRole(REGISTRAR_ROLE) {
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
