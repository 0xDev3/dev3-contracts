// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// File contracts/shared/IVersioned.sol

interface IVersioned {
    function flavor() external view returns (string memory);
    function version() external view returns (string memory);
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.4.2

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// File contracts/shared/Structs.sol

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
        string contractFlavor;
        string contractVersion;
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


// File contracts/shared/IIssuerCommon.sol

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


// File contracts/issuer/IIssuer.sol

interface IIssuer is IIssuerCommon {

    // Write

    function changeOwnership(address newOwner) external;

    // Read
    
    function getState() external view returns (Structs.IssuerState memory);
    function getInfoHistory() external view returns (Structs.InfoEntry[] memory);
    function getWalletRecords() external view returns (Structs.WalletRecord[] memory);

}


// File contracts/issuer/Issuer.sol

contract Issuer is IIssuer {

    //------------------------
    //  STATE
    //------------------------
    Structs.IssuerState private state;
    Structs.InfoEntry[] private infoHistory;
    Structs.WalletRecord[] private approvedWallets;
    mapping (address => uint256) public approvedWalletsMap;

    //------------------------
    //  EVENTS
    //------------------------
    event WalletWhitelist(address indexed approver, address indexed wallet);
    event WalletBlacklist(address indexed approver, address indexed wallet);
    event ChangeOwnership(address caller, address newOwner, uint256 timestamp);
    event ChangeWalletApprover(address caller, address oldWalletApprover, address newWalletApprover, uint256 timestamp);
    event SetInfo(string info, address setter, uint256 timestamp);

    //------------------------
    //  CONSTRUCTOR
    //------------------------
    constructor(
        address owner,
        address stablecoin,
        address walletApprover,
        string memory info
    ) {
        require(owner != address(0), "Issuer: invalid owner address");
        require(stablecoin != address(0), "Issuer: invalid stablecoin address");
        require(walletApprover != address(0), "Issuer: invalid wallet approver address");
        
        infoHistory.push(Structs.InfoEntry(
            info,
            block.timestamp
        ));
        state = Structs.IssuerState(
            "dev3.issuer",
            "1.0.0",
            address(this),
            owner,
            stablecoin,
            walletApprover,
            info
        );
        _setWalletState(owner, true);
    }

    //------------------------
    //  MODIFIERS
    //------------------------
    modifier ownerOnly {
        require(
            msg.sender == state.owner,
            "Issuer: Only owner can make this action."
        );
        _;
    }

    modifier walletApproverOnly {
        require(
            msg.sender == state.walletApprover,
            "Issuer: Only wallet approver can make this action."
        );
        _;
    }
    
    //------------------------
    //  IIssuer IMPL
    //------------------------
    function setInfo(string memory info) external override ownerOnly {
        infoHistory.push(Structs.InfoEntry(
            info,
            block.timestamp
        ));
        state.info = info;
        emit SetInfo(info, msg.sender, block.timestamp);
    }

    function approveWallet(address wallet) external override walletApproverOnly {
        _setWalletState(wallet, true);
        emit WalletWhitelist(msg.sender, wallet);
    }

    function suspendWallet(address wallet) external override walletApproverOnly {
        _setWalletState(wallet, false);
        emit WalletBlacklist(msg.sender, wallet);
    }

    function changeOwnership(address newOwner) external override ownerOnly {
        state.owner = newOwner;
        emit ChangeOwnership(msg.sender, newOwner, block.timestamp);
    }

    function changeWalletApprover(address newWalletApprover) external override {
        require(
            msg.sender == state.owner ||
            msg.sender == state.walletApprover,
            "Issuer: not allowed to call this function."
        );
        state.walletApprover = newWalletApprover;
        emit ChangeWalletApprover(msg.sender, state.walletApprover, newWalletApprover, block.timestamp);
    }

    function flavor() external view override returns (string memory) { return state.flavor; }

    function version() external view override returns (string memory) { return state.version; }

    function commonState() external view override returns (Structs.IssuerCommonState memory) {
        return Structs.IssuerCommonState(
            state.flavor,
            state.version,
            state.contractAddress,
            state.owner,
            state.stablecoin,
            state.walletApprover,
            state.info
        );
    }

    function getState() external override view returns (Structs.IssuerState memory) { return state; }
    
    function isWalletApproved(address wallet) external view override returns (bool) {
        return (_addressExists(wallet) && approvedWallets[approvedWalletsMap[wallet]].whitelisted);
    }

    function getInfoHistory() external view override returns (Structs.InfoEntry[] memory) {
        return infoHistory;
    }

    function getWalletRecords() external view override returns (Structs.WalletRecord[] memory) {
        return approvedWallets;
    }

    //------------------------
    //  Helpers
    //------------------------
    function _setWalletState(address wallet, bool whitelisted) private {
        if (_addressExists(wallet)) {
            approvedWallets[approvedWalletsMap[wallet]].whitelisted = whitelisted;
        } else {
            approvedWallets.push(Structs.WalletRecord(wallet, whitelisted));
            approvedWalletsMap[wallet] = approvedWallets.length - 1;
        }
    }

    function _addressWhitelisted(address wallet) private view returns (bool) {
        return _addressExists(wallet) && approvedWallets[approvedWalletsMap[wallet]].whitelisted;
    }

    function _addressExists(address wallet) private view returns (bool) {
        uint256 index = approvedWalletsMap[wallet];
        if (index >= approvedWallets.length) { return false; }
        return approvedWallets[index].wallet == wallet;
    }

}
