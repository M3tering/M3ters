// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./interfaces/IM3ter.sol";
import "./ERC721ABC.sol";

/// @custom:security-contact info@whynotswitch.com
contract M3ter is ERC721ABC, IM3ter {
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 public nextTokenId;

    mapping(uint256 => bytes32) public keyByToken;
    mapping(bytes32 => uint256) public tokenByKey;

    constructor() ERC721("M3ter", "M3R") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(REGISTRAR_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    function safeMint(
        address to,
        string memory uri
    ) external onlyRole(MINTER_ROLE) whenNotPaused {
        uint256 tokenId = nextTokenId++;
        _setTokenURI(tokenId, uri);
        _safeMint(to, tokenId);
    }

    function register(
        uint256 tokenId,
        bytes32 publicKey
    ) external onlyRole(REGISTRAR_ROLE) whenNotPaused {
        keyByToken[tokenId] = publicKey;
        tokenByKey[publicKey] = tokenId;
        emit Register(tokenId, publicKey, msg.sender, block.timestamp);
    }
}
