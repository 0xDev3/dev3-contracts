# CfManagerSoftcap

Crowdfunding contract implementation. Enables selling one ERC20 token in exchange for another ERC20 token. Investor in the campaign can claim tokens they bought only after the campaign has been closed succesfully by the campaign owner. 

## Deployment

The campaign creator defines the address of the token to be sold (`token1`) and the token to be accepted as the accepted payment method (`token2`).

Other than these, the campaign owner can configure follwing properties at the campaign creation (deployment) time and in the following order:
1. [address] `campaign owner` - address of the wallet with the admin rights
2. [address] `token1` - token to be sold using this campaign
3. [address] `issuer` - address of the organization created with dev3 framework, under which this campaign is being created. This parameter is optional and can be omitted by setting the address to `address zero`. 
4. [address] `token2` - token to be accepted as the payment method for buying `token1`
5. [uint256] `tokenPrice` - price of `token1`
6. [uint8] `tokenPriceDecimals` - precision for the `tokenPrice` param. To sell 1 `token1` for 1.337 `token2`, configure `tokenPrice=1337; tokenPriceDecimals=3;`
7. [uint256] `softcap` - minimum funds amount of `token2` to be raised in the campaign to consider the campaign succesful. Campaign cannot be closed by the campaign owner unless this amount has been reached. If set to 0 soft cap is ignored and campaign can be closed whenever campaign owner chooses to do so.
8. [uint256] `minInvestment` - minimum per wallet investment. Wallets can invest multiple times and add to their investment in the campaign, but the total amount of the funds invested by the single wallet must be at least `minInvestment` amount of `token2`. Set to 0 if you don't need this constraint for your campaign.
9. [uint256] `maxInvestment` - maximum per wallet investment. Wallets can invest multiple times and add to their investment in the campaign, but the total amount of the funds by the single wallet can't go above this amount of `token2`.
10. [boolean] `whitelistRequired` - only makes sense to enable this if `issuer` param was configured. In that case, investors must be whitelisted within the `issuer` mapping before being allowed to invest in the campaign.
11. [string] `info` - textual description of the campaign.
12. [address] `feeManager` - address of the contract handling the fees on successful campaigns. The fee is calculated as the percentage of the `token2` funds raised through the campaign and is automatically routed to the beneficiary address defined in the `feeManager` contract. Dev3 collection contains the implementation of the fee manager with the required override for this mechanism to work. Fee manager is optional and can be omitted by providing `address zero` value here.

## States

One smart contract instance represents one crowdfuding campaign and every campaign
can be in one of three states:
1. open for funding
2. canceled
3. finalized

### Open for funding

After the campaign is deployed and configured, the `token1` tokens must be transferred to the contract address using the regular erc20 transfer method. Seller can send any amount of tokens for sale, and he can do this repeatedly if he wishes to increase the number of tokens to be sold within one active crowdfunding campaign.

Once the first tokens are transferred, the campaign is considered to be in the "open for funding" state. In this state, investors can actively invest in the campaign and reserve their `token1` amounts by spending `token2`, at a configured `tokenPrice`, all done by interacting with the campaign contract.

If all of the tokens have been reserved, new investments are not possible as there's no more tokens left to be sold, and the campaign owner must either close the campaign or send more tokens to the campaign contract.

### Finalized

Campaign owner can choose to finalize campaign as soon as the soft cap has been reached, or at any point later in the funding process. When owner finalizes the campaign, funds raised (`token2`) are automatically sent to his wallet, minus the fees taken by the fee manager (if manager is provided). 
Investors, on the other hand, are then free to claim their bought `token1` tokens from the campaign contract. In the end, the campaign contract is drained of all of the tokens and the process is fully complete.

### Canceled

Campaign owner can also choose to cancel the campaign if the campaign is in the "open for funding" state. He can do so for one reason or another, but when the action is executed, the campaign goes to the "canceled" state which is considered to be a dead end. In this case, the existing investors can pull back their investments (`token2`), while the campaign owner is refunded with all of `token1` tokens he transferred to the campaign. In the end again, the contrat is drained of all of the tokens and the process is fully complete.
