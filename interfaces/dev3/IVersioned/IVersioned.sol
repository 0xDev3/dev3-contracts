// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVersioned {
    function flavor() external view returns (string memory);
    function version() external view returns (string memory);
}
