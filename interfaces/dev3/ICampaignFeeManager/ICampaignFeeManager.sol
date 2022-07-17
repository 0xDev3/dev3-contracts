// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../IVersioned/IVersioned.sol";

interface ICampaignFeeManager is IVersioned  {
    event SetCampaignFee(address campaign, bool initialized, uint256 nominator, uint256 denominator, uint256 timestamp);

    function setCampaignFee(address campaign, bool initialized, uint256 numerator, uint256 denominator) external;
    function calculateFee(address campaign) external view returns (address treasury, uint256 fee);
}
