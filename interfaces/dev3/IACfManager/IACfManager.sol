// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ICampaignCommon/ICampaignCommon.sol";

interface IACfManager is ICampaignCommon {
    function getInfoHistory() external view returns (Structs.InfoEntry[] memory);
    function changeOwnership(address newOwner) external;
}
