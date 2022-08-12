 [ERC721](https://docs.openzeppelin.com/contracts/4.x/erc721) token, including:
 - ability for holders to burn (destroy) their tokens
 - a minter role that allows for token minting (creation)
 - a pauser role that allows to stop all token transfers
 - token ID and URI autogeneration
 
This contract uses [AccessControl](https://docs.openzeppelin.com/contracts/4.x/access-control) to lock permissioned functions using the
different roles - head to its documentation for details.
 
The account that deploys the contract will be granted the minter and pauser
roles, as well as the default admin role, which will let it grant both minter
and pauser roles to other accounts.
