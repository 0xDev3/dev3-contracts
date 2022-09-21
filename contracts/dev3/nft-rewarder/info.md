# Rewarder

This contract enables a contract owner to create redeemable coupons.
This coupons can be claimed by whoever has the access to the coupon's secret key.

By claiming the coupon, the user receives the single nft item from the nft collection defined by the coupon's data. Once the coupon is consumed, it is marked as used and cannot be redeemed again.

## Coupon generation

To create the redeemable coupon admin must generate all the data off-chain and then store the public part of the coupon data by calling the `addRewards` function which marks the generated coupon as active.

The secret part of the coupon data is called the `secret key`, which is predefined by coupon creator and used to generate the coupon data. Anyone with an access to this key can redeem coupon marking it as consumed.

One Rewarder contract can handle multiple coupons, and different reward tokens can be used for every coupon.

To generate and activate the coupon, the following method is used:
- admin generates secret key which is an arbitrary text value (for example: "CFW2A3R7YD")
- admin generates coupon identifier (public info) off-chain by combining the Rewarder contract address (for example "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48") and a generated secret key in a following way:
    - `id = keccak256(abi.encodePacked(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, "CFW2A3R7YD"))`
- admin constructs a coupon object by combining the generated coupon id and choosing the values for the rest of parameters:
    1. generated id
    2. nft collection (token address)
    3. concrete token id from the given collection (token id)
    4. expiry date of the coupon
- admin calls the `addRewards` function and provides all of the coupon data from step before. `addRewards` accepts a list of generated coupons and will activate all of them at once .
- admin makes sure that he is the owner of the token id from the collection and he approved the rewarder to manage this token id, for example by calling the `setApprovalForAll()` function on the NFT collection contract and granting the Rewarder contract the rights to manage all of his nfts
- admin then distributes the secret keys the end users

Secret key is the only thing required for someone to claim the coupon.
To claim rewards, user simply calls the `claimReward` function and provides the key as the only parameter. If the coupon with this key exists and is not expired or consumed, the user will be rewarded with the tokens and native coins assigned to the specified coupon.

## NFT revocation

Admin can always choose to revoke the rights for the Rewarder to distribute his nft's by calling the  `setApprovalForAll()` function on the nft collection contract and blocking the Rewarder contract from accessing his nft's.
