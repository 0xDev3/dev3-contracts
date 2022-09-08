# Supply Chain Manager

This implementation demonstrates how Smart Contract could be used to track one supply chain process where
produced items go from production and packaging stage, to shipment and in the end reach the final buyer.

The contract can be used to track all of the products and their states:
- produced
- packed
- shipped
- received

The contract also serves as some form of an escrow -> the producer will not get paid for the prodact until the product
has verifiably reached the buyer side.

## Contract creation

To initialize one supply chain contract three parameters must be provided:
1. manager -> wallet address of the supply chain manager. This address can add or remove users with specific roles in the supply chain process.
2. manufacturer -> wallet address of the manufacturer. This is where the revenue is routed automatically once the products reacht the buyer (end of the chain).
3. payment currency -> token address used as the accepted payment method used by the buyers to pay for product

## Supply chain

Every product must be introduced in the system once it's produced.
Users with the role 'PRODUCER' can introduce new products in the system and describe them with following 4 parameters:
- barcode (unique product identifier)
- price (in defined payment currency)
- product description
- additional info

Once the product is packed, users with the role 'PACKER' can mark the product as packed. In the real world, these users or machines would be granted the role and they would be able to automatically mark the products as packed by scanning their unique barcode provided in the step before. 

Now the product is produced, and packed, it is taken for shipping by the shipping agency. Their workers are granted the role 'SHIPPER' and are allowed to mark the product as shipped once it reaches its destination.

Finally , the end user with the role 'RECEIVER' has recieved its product and he can verify this by scanning the code on the product. This will mark the product as received (last step in the chain) and will automatically pay the manufacturer for the product by using the funds locked by the buyer and transfered to the supply chain contract before the process was started.

## Reading state
,
At every point, anyone can query the state of the supply chain and transparently verify the activity happening with all of the products introduced in the system.

`getUsers()` will return all of the privileged users and their roles in the system

`getProducts()` will return all of the products introduced in the system, containing the state and other important information

`getProductHistory()` will return all of the events (state changes) triggered for one concrete product

`getUserHistory()` will return all of the actions taken by one concrete user