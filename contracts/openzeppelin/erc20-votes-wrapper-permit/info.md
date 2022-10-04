# Voting Token

If you want your token to support voting and delegation the token must support [ERC20Votes](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#ERC20Votes) extension.

Luckily, if your project already has a live token that does not include ERC20Votes and is not upgradeable, you can wrap it in a governance token by using this implementation of Voting Token.

This will allow your original token holders to participate in governance by wrapping their tokens 1-to-1 and minting the Voting Token tokens by depositing the orginal (underlying) token.

This Voting Token implements following traits:

## ERC20Permit

[ERC20Permit](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#ERC20Permit) allows ERC20 approvals to be made via signatures, as defined in [EIP-2612](https://eips.ethereum.org/EIPS/eip-2612).

## ERC20Votes

[ERC20Votes](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#ERC20Votes) is an extension of ERC20 to support Compound-like voting and delegation. This extension keeps a history (checkpoints) of each account’s vote power. Vote power can be delegated either by calling the *delegate()* function directly, or by providing a signature to be used with *delegateBySig()*. Voting power can be queried through the public accessors *getVotes()* and *getPastVotes()*.

This extension will keep track of historical balances so that voting power is retrieved from past snapshots rather than current balance, which is an important protection that prevents double voting.

## ERC20Wrapper

Extension of the ERC20 token contract to support token wrapping.

Users can deposit and withdraw "underlying tokens" and receive a matching number of "wrapped tokens". This is useful in conjunction with other modules. For example, combining this wrapping mechanism with ERC20Votes will allow the wrapping of an existing "basic" ERC20 into a governance token.

