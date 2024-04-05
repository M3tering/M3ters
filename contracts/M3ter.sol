// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./interfaces/IM3ter.sol";
import "./XRC721.sol";

/// @custom:security-contact info@whynotswitch.com
contract M3ter is XRC721, IM3ter {
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");
    uint256 private _nextTokenId;

    mapping(uint256 => bytes32) public token_to_key;
    mapping(bytes32 => uint256) public key_to_token;

    constructor() ERC721("M3ter", "M3R") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(REGISTRAR_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    function safeMint(address to, string memory uri) public whenNotPaused {
        uint256 tokenId = _nextTokenId++;
        _setTokenURI(tokenId, uri);
        _safeMint(to, tokenId);
    }

    function _register(
        uint256 tokenId,
        bytes32 publicKey
    ) external onlyRole(REGISTRAR_ROLE) {
        token_to_key[tokenId] = publicKey;
        key_to_token[publicKey] = tokenId;
        emit Register(tokenId, publicKey, msg.sender, block.timestamp);
    }
}
