// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../common/IERC20/IERC20.sol";

contract Structs {

    struct IssuerCommonState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        address stablecoin;
        address walletApprover;
        string info;
    }

    struct IssuerCommonStateWithName {
        IssuerCommonState issuer;
        string mappedName;
    }

    struct AssetCommonState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        string info;
        string name;
        string symbol;
        uint256 totalSupply;
        uint8 decimals;
        address issuer;
    }

    struct ERC20AssetCommonState {
        address contractAddress;
        uint8 decimals;
        string name;
        string symbol;
        AssetCommonState commonState;
    }

    struct AssetCommonStateWithName {
        AssetCommonState asset;
        string mappedName;
    }
        
    struct CampaignFactoryParams {
        address owner;
        string mappedName;
        address assetAddress;
        address issuerAddress;
        address paymentToken;
        uint256 initialPricePerToken;
        uint8 tokenPriceDecimals;
        uint256 softCap;
        uint256 minInvestment;
        uint256 maxInvestment;
        bool whitelistRequired;
        string info;
        address nameRegistry;
        address feeManager;
    }

    struct CampaignConstructor {
        address owner;
        address asset;
        address issuer;
        address paymentToken;
        uint256 tokenPrice;
        uint8 tokenPriceDecimals;
        uint256 softCap;
        uint256 minInvestment;
        uint256 maxInvestment;
        bool whitelistRequired;
        string info;
        address feeManager;
    }

    struct CampaignCommonState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        string info;
        address asset;
        address stablecoin;
        uint256 softCap;
        bool finalized;
        bool canceled;
        uint256 pricePerToken;
        uint8 tokenPriceDecimals;
        uint256 fundsRaised;
        uint256 tokensSold;
    }

    struct CampaignCommonStateWithName {
        CampaignCommonState campaign;
        string mappedName;
    }

    struct CampaignCommonStateWithNameAndInvestment {
        CampaignCommonState campaign;
        string mappedName;
        uint256 tokenAmount;
        uint256 tokenValue;
    }

    struct TokenSaleInfo {
        address cfManager;
        uint256 tokenAmount;
        uint256 tokenValue;
        uint256 timestamp;
    }

    struct AssetRecord {
        address originalToken;
        address mirroredToken;
        bool exists;
        bool state;
        uint256 stateUpdatedAt;
        uint256 price;
        uint8 priceDecimals;
        uint256 priceUpdatedAt;
        uint256 priceValidUntil;
        uint256 capturedSupply;
        address priceProvider;
    }

    struct TokenPriceRecord {
        uint256 price;
        uint256 updatedAtTimestamp;
        uint256 validUntilTimestamp;
        uint256 capturedSupply;
        address provider;
    }

    struct AssetSimpleFactoryParams {
        address creator;
        address issuer;
        string mappedName;
        address nameRegistry;
        uint256 initialTokenSupply;
        string name;
        string symbol;
        string info;
    }

    struct AssetTransferableFactoryParams {
        address creator;
        address issuer;
        address apxRegistry;
        string mappedName;
        address nameRegistry;
        uint256 initialTokenSupply;
        bool whitelistRequiredForRevenueClaim;
        bool whitelistRequiredForLiquidationClaim;
        string name;
        string symbol;
        string info;
    }

    struct AssetFactoryParams {
        address creator;
        address issuer;
        address apxRegistry;
        address nameRegistry;
        string mappedName;
        uint256 initialTokenSupply;
        bool transferable;
        bool whitelistRequiredForRevenueClaim;
        bool whitelistRequiredForLiquidationClaim;
        string name;
        string symbol;
        string info;
    }

    struct AssetSimpleConstructorParams {
        string flavor;
        string version;
        address owner;
        address issuer;
        uint256 initialTokenSupply;
        string name;
        string symbol;
        string info;
    }

    struct AssetConstructorParams {
        string flavor;
        string version;
        address owner;
        address issuer;
        address apxRegistry;
        uint256 initialTokenSupply;
        bool transferable;
        bool whitelistRequiredForRevenueClaim;
        bool whitelistRequiredForLiquidationClaim;
        string name;
        string symbol;
        string info;
    }

    struct AssetTransferableConstructorParams {
        string flavor;
        string version;
        address owner;
        address issuer;
        address apxRegistry;
        uint256 initialTokenSupply;
        bool whitelistRequiredForRevenueClaim;
        bool whitelistRequiredForLiquidationClaim;
        string name;
        string symbol;
        string info;
    }

    struct AssetSimpleState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        string info;
        string name;
        string symbol;
        uint256 totalSupply;
        uint8 decimals;
        address issuer;
        bool assetApprovedByIssuer;
        uint256 totalAmountRaised;
        uint256 totalTokensSold;
    }

    struct AssetState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        uint256 initialTokenSupply;
        bool transferable;
        bool whitelistRequiredForRevenueClaim;
        bool whitelistRequiredForLiquidationClaim;
        bool assetApprovedByIssuer;
        address issuer;
        address apxRegistry;
        string info;
        string name;
        string symbol;
        uint256 totalAmountRaised;
        uint256 totalTokensSold;
        uint256 highestTokenSellPrice;
        uint8 highestTokenSellPriceDecimals;
        uint256 totalTokensLocked;
        uint256 totalTokensLockedAndLiquidated;
        bool liquidated;
        uint256 liquidationFundsTotal;
        uint256 liquidationTimestamp;
        uint256 liquidationFundsClaimed;
    }

    struct AssetTransferableState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        uint256 initialTokenSupply;
        bool whitelistRequiredForRevenueClaim;
        bool whitelistRequiredForLiquidationClaim;
        bool assetApprovedByIssuer;
        address issuer;
        address apxRegistry;
        string info;
        string name;
        string symbol;
        uint256 totalAmountRaised;
        uint256 totalTokensSold;
        uint256 highestTokenSellPrice;
        uint8 highestTokenSellPriceDecimals;
        bool liquidated;
        uint256 liquidationFundsTotal;
        uint256 liquidationTimestamp;
        uint256 liquidationFundsClaimed;
    }
    
    struct AssetBalance {
        address contractAddress;
        uint8 decimals;
        string name;
        string symbol;
        uint256 balance;
        AssetCommonState assetCommonState;
    }

    struct IssuerState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        address stablecoin;
        address walletApprover;
        string info;
    }

    struct CfManagerState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        address asset;
        address issuer;
        address stablecoin;
        uint256 tokenPrice;
        uint8 tokenPriceDecimals;
        uint256 softCap;
        uint256 minInvestment;
        uint256 maxInvestment;
        bool whitelistRequired;
        bool finalized;
        bool canceled;
        uint256 totalClaimableTokens;
        uint256 totalInvestorsCount;
        uint256 totalFundsRaised;
        uint256 totalTokensSold;
        uint256 totalTokensBalance;
        string info;
        address feeManager;
    }

    struct CfManagerSoftcapState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        address asset;
        address issuer;
        address stablecoin;
        uint256 tokenPrice;
        uint256 softCap;
        uint256 minInvestment;
        uint256 maxInvestment;
        bool whitelistRequired;
        bool finalized;
        bool canceled;
        uint256 totalClaimableTokens;
        uint256 totalInvestorsCount;
        uint256 totalClaimsCount;
        uint256 totalFundsRaised;
        uint256 totalTokensSold;
        uint256 totalTokensBalance;
        string info;
        address feeManager;
    }

    struct CfManagerSoftcapVestingState {
        string flavor;
        string version;
        address contractAddress;
        address owner;
        address asset;
        address issuer;
        address stablecoin;
        uint256 tokenPrice;
        uint256 softCap;
        uint256 minInvestment;
        uint256 maxInvestment;
        bool whitelistRequired;
        bool finalized;
        bool canceled;
        uint256 totalClaimableTokens;
        uint256 totalInvestorsCount;
        uint256 totalFundsRaised;
        uint256 totalTokensSold;
        uint256 totalTokensBalance;
        string info;
        bool vestingStarted;
        uint256 start;
        uint256 cliff;
        uint256 duration;
        bool revocable;
        bool revoked;
        address feeManager;
    }
    
    struct InfoEntry {
        string info;
        uint256 timestamp;
    }
    
    struct WalletRecord {
        address wallet;
        bool whitelisted;
    }

    struct Payout {
        uint256 payoutId; // ID of this payout
        address payoutOwner; // address which created this payout
        string payoutInfo; // payout info (or IPFS hash for info)
        bool isCanceled; // determines if this payout is canceled

        IERC20 asset; // asset for which payout is being made
        uint256 totalAssetAmount; // sum of all asset holdings in the snapshot, minus ignored asset address holdings
        address[] ignoredHolderAddresses; // addresses which aren't included in the payout

        bytes32 assetSnapshotMerkleRoot; // Merkle root hash of asset holdings in the snapshot, without ignored addresses
        uint256 assetSnapshotMerkleDepth; // depth of snapshot Merkle tree
        uint256 assetSnapshotBlockNumber; // snapshot block number
        string assetSnapshotMerkleIpfsHash; // IPFS hash of stored asset snapshot Merkle tree

        IERC20 rewardAsset; // asset issued as payout reward
        uint256 totalRewardAmount; // total amount of reward asset in this payout
        uint256 remainingRewardAmount; // remaining reward asset amount in this payout
    }

}
