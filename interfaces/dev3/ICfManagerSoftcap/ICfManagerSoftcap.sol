// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../IACfManager/IACfManager.sol";
import "../Structs.sol";

interface ICfManagerSoftcap is IACfManager {
    function getState() external view returns (Structs.CfManagerSoftcapState memory);
}
