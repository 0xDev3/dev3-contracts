[ERC721](https://docs.openzeppelin.com/contracts/4.x/erc721) token, including
- admin role
- ability for admin to repeatedly mint new tokens
- ability for admin to update baseURI pointing to the ipfs collection of token manifests
- token ID and URI autogeneration

Once the admin has minted the final amount of tokens and has configured the tokenURI properly, admin is supposed
to renounce his role marking this nft collection as final.
