// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../IERC721/IERC721.sol";

interface IERC721Burnable is IERC721 {
    function burn(uint256 tokenId) external;
}
