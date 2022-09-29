# Smart Contracts Collection

This repo represents a list of smart contracts ready to be deployed and used as the base building blocks in
creating more complex blockchain solutions.

Web3 developers community is welcome to contribute to the repository by opening pull requests and contributing with their
own smart contract implementations, or making suggestions on how this repo should be structured to provide the most value for the builders. Feel free to raise an issue here

[Dev3 Platform](https://app.dev3.sh), a low-code rapid blockchain development platform, is reading directly from this repository's master branch and exposes all of the smart contracts on the platform dashboard where others can choose from the list and deploy contracts on a click, be it for development purposes, just playing around, or deploying actual production-ready smart contracts.

## Repository Structure

Contracts collection is organized by introducing namespaces. The root directory is `contracts` and every smart contract implementation is stored within its own organization namespace available inside the `contracts` directory, as shown below.

```
contracts
|
| ----- organization-A
|             |
|              ---------- contract-1
|             |               |
|             |               |---- contract-1.sol
|             |               |---- manifest.json
|             |               |---- artifact.json
|             |               |---- info.md
|             |
|              ----------- contract-2
|             |               |
|             |     .         |---- contract-2.sol
|             |     .         |---- manifest.json
|             |     .         |---- artifact.json
|                             |---- info.md
|                           
| ----- organization-B
|             .
|             .
|             .
```
If you, as an individual, or a new organization/startup/company/DAO, want to contribute your own smart contract implementation but your organization namespace is missing, simply create it in the `contracts` hierarchy and the add the implementation within the created namespace.

We at [0xDev3](dev3.sh) propose a standardized way of adding new deployable smart contract implementations and the full process is described [here](docs/CONTRIBUTING.md).
