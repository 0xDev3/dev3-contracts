# Vesting Wallet

This contract handles the vesting of Eth and ERC20 tokens for a given beneficiary. Custody of multiple tokens can be given to this contract, which will release the token to the beneficiary following a given vesting schedule. The vesting schedule is customizable through the vestedAmount function.

Any token transferred to this contract will follow the vesting schedule as if they were locked from the beginning. Consequently, if the vesting has already started, any amount of tokens sent to this contract will (at least partly) be immediately releasable.
