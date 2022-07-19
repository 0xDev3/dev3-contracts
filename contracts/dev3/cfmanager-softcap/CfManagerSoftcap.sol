// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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


// File @openzeppelin/contracts/utils/Address.sol@v4.4.2

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol@v4.4.2

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// File contracts/shared/IVersioned.sol

interface IVersioned {
    function flavor() external view returns (string memory);
    function version() external view returns (string memory);
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


// File contracts/shared/ICampaignCommon.sol

interface ICampaignCommon is IVersioned {

    // WRITE
    function setInfo(string memory info) external;
    
    // READ
    function commonState() external view returns (Structs.CampaignCommonState memory);
    function investmentAmount(address investor) external view returns (uint256);
    function tokenAmount(address investor) external view returns (uint256);
    function claimedAmount(address investor) external view returns (uint256);

}


// File contracts/managers/IACfManager.sol

interface IACfManager is ICampaignCommon {
    function getInfoHistory() external view returns (Structs.InfoEntry[] memory);
}


// File contracts/managers/crowdfunding-softcap/ICfManagerSoftcap.sol

interface ICfManagerSoftcap is IACfManager {
    function getState() external view returns (Structs.CfManagerSoftcapState memory);
}


// File @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol@v4.4.2

pragma solidity ^0.8.0;

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}


// File contracts/tokens/erc20/IToken.sol

interface IToken is IERC20, IERC20Metadata {
    function balanceBeforeLiquidation(address account) external view returns (uint256);
}


// File contracts/shared/IAssetCommon.sol

interface IAssetCommon is IVersioned {
    
    // WRITE
    function setInfo(string memory info) external;
    function finalizeSale() external;
    
    // READ
    function commonState() external view returns (Structs.AssetCommonState memory);

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


// File @openzeppelin/contracts/utils/Context.sol@v4.4.2

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File @openzeppelin/contracts/access/Ownable.sol@v4.4.2

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


// File contracts/managers/ACfManager.sol

abstract contract ACfManager is IVersioned, IACfManager, Ownable {
    using SafeERC20 for IERC20;

    //------------------------
    //  STATE
    //------------------------
    Structs.CfManagerState internal state;
    Structs.InfoEntry[] internal infoHistory;
    mapping (address => uint256) internal claims;
    mapping (address => uint256) internal investments;
    mapping (address => uint256) internal tokenAmounts;

    //------------------------
    //  EVENTS
    //------------------------
    event Invest(
        address indexed investor,
        address asset,
        uint256 tokenAmount,
        uint256 tokenValue,
        uint256 timestamp
    );
    event Claim(
        address indexed investor,
        address asset,
        uint256 tokenAmount,
        uint256 tokenValue,
        uint256 timestamp
    );
    event CancelInvestment(
        address indexed investor,
        address asset,
        uint256 tokenAmount,
        uint256 tokenValue,
        uint256 timestamp
    );
    event Finalize(
        address indexed owner,
        address asset,
        uint256 fundsRaised,
        uint256 tokensSold,
        uint256 tokensRefund,
        uint256 timestamp
    );
    event CancelCampaign(address indexed owner, address asset, uint256 tokensReturned, uint256 timestamp);
    event SetInfo(string info, address setter, uint256 timestamp);

    //------------------------
    //  MODIFIERS
    //------------------------
    modifier active() {
        require(
            !state.canceled,
            "ACfManager: The campaign has been canceled."
        );
        _;
    }

    modifier finalized() {
        require(
            state.finalized,
            "ACfManager: The campaign is not finalized."
        );
        _;
    }

    modifier notFinalized() {
        require(
            !state.finalized,
            "ACfManager: The campaign is finalized."
        );
        _;
    }

    modifier isWhitelisted(address investor) {
        require(
            isWalletWhitelisted(investor),
            "ACfManager: Wallet not whitelisted."
        );
        _;
    }

    //------------------------
    // STATE CHANGE FUNCTIONS
    //------------------------
    function invest(uint256 amount) external {
        _invest(msg.sender, msg.sender, amount);
    }

    function investForBeneficiary(address spender, address beneficiary, uint256 amount) external {
        if (spender != beneficiary) {
            require(
                spender == msg.sender,
                "ACfManager: Only spender can decide to book the investment on someone else."
            );
        }
        _invest(spender, beneficiary, amount);
    }

    function cancelInvestment() external notFinalized {
        _cancel_investment(msg.sender);
    }

    function cancelInvestmentFor(address investor) external {
        require(
            state.canceled,
            "ACfManager: Can only cancel for someone if the campaign has been canceled."
        );
        _cancel_investment(investor);
    }

    function finalize() external onlyOwner active notFinalized {
        IERC20 sc = stablecoin();
        uint256 fundsRaised = sc.balanceOf(address(this));
        require(
            fundsRaised >= state.softCap || _token_value_to_soft_cap() == 0,
            "ACfManager: Can only finalize campaign if the minimum funding goal has been reached."
        );
        state.finalized = true;
        IERC20 assetERC20 = _assetERC20();
        uint256 tokensSold = state.totalTokensSold;
        uint256 tokensRefund = assetERC20.balanceOf(address(this)) - tokensSold;
        _safeFinalizeSale();
        _safeDistributeFunds(msg.sender, fundsRaised, sc);
        if (tokensRefund > 0) { assetERC20.safeTransfer(msg.sender, tokensRefund); }
        emit Finalize(msg.sender, state.asset, fundsRaised, tokensSold, tokensRefund, block.timestamp);
    }

    function cancelCampaign() external onlyOwner active notFinalized {
        state.canceled = true;
        uint256 tokenBalance = _assetERC20().balanceOf(address(this));
        if(tokenBalance > 0) { _assetERC20().safeTransfer(msg.sender, tokenBalance); }
        emit CancelCampaign(msg.sender, state.asset, tokenBalance, block.timestamp);
    }

    function flavor() external view override returns (string memory) { return state.flavor; }

    function version() external view override returns (string memory) { return state.version; }

    function commonState() external view override returns (Structs.CampaignCommonState memory) {
        return Structs.CampaignCommonState(
            state.flavor,
            state.version,
            state.contractAddress,
            owner(),
            state.info,
            state.asset,
            state.stablecoin,
            state.softCap,
            state.finalized,
            state.canceled,
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.totalFundsRaised,
            state.totalTokensSold
        );
    }
    function investmentAmount(address investor) external view override returns (uint256) {
        return investments[investor];
    }
    function tokenAmount(address investor) external view override returns (uint256) { return tokenAmounts[investor]; }
    function claimedAmount(address investor) external view override returns (uint256) { return claims[investor]; }

    function setInfo(string memory info) external override onlyOwner {
        infoHistory.push(Structs.InfoEntry(
            info,
            block.timestamp
        ));
        state.info = info;
        emit SetInfo(info, msg.sender, block.timestamp);
    }

    function getInfoHistory() external override view returns (Structs.InfoEntry[] memory) {
        return infoHistory;
    }

    function isWalletWhitelisted(address wallet) public view returns (bool) {
        return !state.whitelistRequired || (state.whitelistRequired && _walletApproved(wallet));
    }

    function stablecoin() public view returns (IERC20) {
        return IERC20(state.stablecoin);
    }

    //------------------------
    //  HELPERS
    //------------------------
    function _invest(address spender, address investor, uint256 amount) internal active notFinalized isWhitelisted(investor) {
        require(amount > 0, "ACfManager: Investment amount has to be greater than 0.");
        uint256 tokenBalance = _assetERC20().balanceOf(address(this));
        require(
            _token_value(
                tokenBalance,
                state.tokenPrice,
                state.tokenPriceDecimals,
                state.asset,
                state.stablecoin
            ) >= state.softCap,
            "ACfManager: not enough tokens for sale to reach the softcap."
        );
        uint256 floatingTokens = tokenBalance - state.totalClaimableTokens;

        uint256 tokens = _token_amount_for_investment(
            amount,
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.asset,
            state.stablecoin
        );
        uint256 tokenValue = _token_value(
            tokens,
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.asset,
            state.stablecoin
        );
        require(tokens > 0 && tokenValue > 0, "ACfManager: Investment amount too low.");
        require(floatingTokens >= tokens, "ACfManager: Not enough tokens left for this investment amount.");
        uint256 totalInvestmentValue = _token_value(
            tokens + claims[investor],
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.asset,
            state.stablecoin
        );
        require(
            totalInvestmentValue >= _adjusted_min_investment(floatingTokens),
            "ACfManager: Investment amount too low."
        );
        require(
            totalInvestmentValue <= state.maxInvestment,
            "ACfManager: Investment amount too high."
        );

        stablecoin().safeTransferFrom(spender, address(this), tokenValue);

        if (claims[investor] == 0) {
            state.totalInvestorsCount += 1;
        }
        claims[investor] += tokens;
        investments[investor] += tokenValue;
        tokenAmounts[investor] += tokens;
        state.totalClaimableTokens += tokens;
        state.totalTokensSold += tokens;
        state.totalFundsRaised += tokenValue;
        emit Invest(investor, state.asset, tokens, tokenValue, block.timestamp);
    }

    function _cancel_investment(address investor) internal {
        uint256 tokens = claims[investor];
        uint256 tokenValue = investments[investor];
        require(
            tokens > 0 && tokenValue > 0,
            "ACfManager: No tokens owned."
        );
        state.totalInvestorsCount -= 1;
        claims[investor] = 0;
        investments[investor] = 0;
        tokenAmounts[investor] = 0;
        state.totalClaimableTokens -= tokens;
        state.totalTokensSold -= tokens;
        state.totalFundsRaised -= tokenValue;
        stablecoin().safeTransfer(investor, tokenValue);
        emit CancelInvestment(investor, state.asset, tokens, tokenValue, block.timestamp);
    }

    function _safeFinalizeSale() internal {
        state.asset.call(
            abi.encodeWithSignature("finalizeSale()")
        );
    }

    function _safeDistributeFunds(address fundsDestination, uint256 fundsRaised, IERC20 sc) internal {
        if (fundsRaised > 0) {
            (address treasury, uint256 fee) = _calculateFee();
            if (fee > 0 && treasury != address(0)) {
                sc.safeTransfer(treasury, fee);
                sc.safeTransfer(fundsDestination, fundsRaised - fee);
            } else {
                sc.safeTransfer(fundsDestination, fundsRaised);
            }
        }
    }

    function _calculateFee() internal returns (address, uint256) {
        (bool success, bytes memory result) = state.feeManager.call(
            abi.encodeWithSignature("calculateFee(address)", address(this))
        );
        if (success) {
            return abi.decode(result, (address, uint256));
        } else { return (address(0), 0); }
    }

    function _assetERC20() internal view returns (IERC20) {
        return IERC20(state.asset);
    }

    function _asset_decimals_precision(address asset) internal view returns (uint256) {
        return 10 ** IToken(asset).decimals();
    }

    function _stablecoin_decimals_precision(address stable) internal view returns (uint256) {
        return 10 ** IToken(stable).decimals();
    }

    function _token_value(
        uint256 tokens,
        uint256 tokenPrice,
        uint8 tokenPriceDecimals,
        address asset,
        address stable
    ) internal view returns (uint256) {
        return tokens
        * tokenPrice
        * _stablecoin_decimals_precision(stable)
        / (10 ** tokenPriceDecimals)
        / _asset_decimals_precision(asset);
    }

    function _walletApproved(address wallet) internal view returns (bool) {
        return IIssuerCommon(state.issuer).isWalletApproved(wallet);
    }

    function _adjusted_min_investment(uint256 remainingTokens) internal view returns (uint256) {
        uint256 remainingTokensValue = _token_value(
            remainingTokens,
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.asset,
            state.stablecoin
        );
        return (remainingTokensValue < state.minInvestment) ? remainingTokensValue : state.minInvestment;
    }

    function _token_value_to_soft_cap() private view returns (uint256) {
        uint256 tokenAmountForInvestment = _token_amount_for_investment(
            state.softCap - state.totalFundsRaised,
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.asset,
            state.stablecoin
        );
        return _token_value(
            tokenAmountForInvestment,
            state.tokenPrice,
            state.tokenPriceDecimals,
            state.asset,
            state.stablecoin
        );
    }

    function _token_amount_for_investment(
        uint256 investment,
        uint256 tokenPrice,
        uint8 tokenPriceDecimals,
        address asset,
        address stable
    ) internal view returns (uint256) {
        return investment
        * (10 ** tokenPriceDecimals)
        * _asset_decimals_precision(asset)
        / tokenPrice
        / _stablecoin_decimals_precision(stable);
    }

    function _safe_issuer_fetch(address asset) internal view returns (address) {
        (bool success, bytes memory result) = asset.staticcall(
            abi.encodeWithSignature("commonState()")
        );
        if (success) {
            Structs.AssetCommonState memory assetCommonState = abi.decode(result, (Structs.AssetCommonState));
            return assetCommonState.issuer;
        } else { return address(0); }
    }
}


// File contracts/managers/crowdfunding-softcap/CfManagerSoftcap.sol

contract CfManagerSoftcap is ICfManagerSoftcap, ACfManager {
    using SafeERC20 for IERC20;

    //------------------------
    //  STATE
    //------------------------
    uint256 private totalClaimsCount = 0;

    //------------------------
    //  CONSTRUCTOR
    //------------------------
    constructor(Structs.CampaignConstructor memory params) {
        require(params.owner != address(0), "CfManagerSoftcap: Invalid owner address");
        require(params.asset != address(0), "CfManagerSoftcap: Invalid asset address");
        require(params.tokenPrice > 0, "CfManagerSoftcap: Initial price per token must be greater than 0.");
        require(
            params.maxInvestment >= params.minInvestment,
            "CfManagerSoftcap: Max has to be bigger than min investment."
        );
        require(params.maxInvestment > 0, "CfManagerSoftcap: Max investment has to be bigger than 0.");
        address fetchedIssuer = _safe_issuer_fetch(params.asset);
        address issuerProcessed = fetchedIssuer != address(0) ? fetchedIssuer : params.issuer;
        require(issuerProcessed == params.issuer, "CfManagerSoftcap: Invalid issuer provided.");
        if (params.whitelistRequired) {
            require(
                issuerProcessed != address(0),
                "CfManagerSoftcap: Issuer must be provided if wallet whitelisting is turned on."
            );
        }

        address paymentTokenProcessed = params.paymentToken == address(0) ?
            IIssuerCommon(issuerProcessed).commonState().stablecoin :
            params.paymentToken;
        uint256 softCapNormalized = _token_value(
            _token_amount_for_investment(
                params.softCap,
                params.tokenPrice,
                params.tokenPriceDecimals,
                params.asset,
                paymentTokenProcessed
            ),
            params.tokenPrice,
            params.tokenPriceDecimals,
            params.asset,
            paymentTokenProcessed
        );
        uint256 minInvestmentNormalized = _token_value(
            _token_amount_for_investment(
                params.minInvestment,
                params.tokenPrice,
                params.tokenPriceDecimals,
                params.asset,
                paymentTokenProcessed
            ),
            params.tokenPrice,
            params.tokenPriceDecimals,
            params.asset,
            paymentTokenProcessed
        );

        state = Structs.CfManagerState(
            "dev3.cfmanager-softcap",
            "1.0.0",
            address(this),
            params.owner,
            params.asset,
            issuerProcessed,
            paymentTokenProcessed,
            params.tokenPrice,
            params.tokenPriceDecimals,
            softCapNormalized,
            minInvestmentNormalized,
            params.maxInvestment,
            params.whitelistRequired,
            false,
            false,
            0, 0, 0, 0, 0,
            params.info,
            params.feeManager
        );
        require(
            _token_value(
                IToken(params.asset).totalSupply(),
                params.tokenPrice,
                params.tokenPriceDecimals,
                params.asset,
                paymentTokenProcessed
            ) >= softCapNormalized,
            "CfManagerSoftcap: Invalid soft cap."
        );
        _transferOwnership(params.owner);
    }

    //------------------------
    // STATE CHANGE FUNCTIONS
    //------------------------
    function claim(address investor) external finalized {
        uint256 claimableTokens = claims[investor];
        uint256 claimableTokensValue = investments[investor];
        require(
            claimableTokens > 0 && claimableTokensValue > 0,
            "CfManagerSoftcap: No tokens owned."
        );
        totalClaimsCount += 1;
        state.totalClaimableTokens -= claimableTokens;
        claims[investor] = 0;
        _assetERC20().safeTransfer(investor, claimableTokens);
        emit Claim(investor, state.asset, claimableTokens, claimableTokensValue, block.timestamp);
    }

    //------------------------
    //  ICfManagerSoftcap IMPL
    //------------------------
    function getState() external view override returns (Structs.CfManagerSoftcapState memory) {
        return Structs.CfManagerSoftcapState(
            state.flavor,
            state.version,
            state.contractAddress,
            owner(),
            state.asset,
            state.issuer,
            state.stablecoin,
            state.tokenPrice,
            state.softCap,
            state.minInvestment,
            state.maxInvestment,
            state.whitelistRequired,
            state.finalized,
            state.canceled,
            state.totalClaimableTokens,
            state.totalInvestorsCount,
            totalClaimsCount,
            state.totalFundsRaised,
            state.totalTokensSold,
            _assetERC20().balanceOf(address(this)),
            state.info,
            state.feeManager
        );
    }
}
