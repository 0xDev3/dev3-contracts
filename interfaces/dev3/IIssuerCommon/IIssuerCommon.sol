// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../IVersioned/IVersioned.sol";
import "../Structs.sol";

interface IIssuerCommon is IVersioned {

    // WRITE
    function setInfo(string memory info) external;
    function approveWallet(address wallet) external;
    function suspendWallet(address wallet) external;
    function changeWalletApprover(address newWalletApprover) external;

    // READ
    function isWalletApproved(address wallet) external view returns (bool);
    function commonState() external view returns (Structs.IssuerCommonState memory);

}
