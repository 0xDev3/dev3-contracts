# Contributing

Thanks for taking the time to improve this repository by suggesting your changes, improvements, or structural modifications in order to bring the most of the value to the web3 developers!

If you like to learn by examples, you can go to the [contracts](../contracts/) directly and check how some of the contracts have been decorated to get an idea of how the process looks like.

Below, you'll find steps on how to contribute by adding your own smart contract implementation.
To a solidity developer, it shouldn't take more than one hour to follow the steps here and decorate their smart contract before opening a pull request.

## 1. Fork

To add your smart contract implementation, you should fork this repo, add your files and then open up a pull request which is going to be reviewed by the 0xDev3 team and the rest of the web3 community before being merged to master and automatically published on the [Dev3 Platform](https://app.dev3.sh)!

## 2. Create contract directory

Create the folder for your organization or namespace inside the `contracts` directory.

For example, if you want to contribute contract `ContractX.sol` and your organization is called `HackerDAO` you'll most likely want to create the 
```
contracts/hacker-dao/contractx/
```
structure, with `contractx` being the directory which is going to hold the files describing your smart contract implementation.

## 3. Add files

To fully describe your smart contract, you need to place exactly 4 files in the created contract directory:

1. `YourContractName.sol`

A single flattened solidity file containing full smart contract implementation compilable with solidity >=0.8.0! 

2. `artifact.json`

The file you get as an output when you compile the `YourContractName.sol` contract. The compiler will usually generate the artifact named the same way as the source code file, for example, when you compile `YourContractName.sol` you will get the output file named `YourContractName.json`. You have to rename it to `artifact.json` when adding it to the contract directory.

3. `manifest.json`

Decorator file describing smart contract parts in a human-readable and understandable way! As opposed to the files 1 and 2, this one you need to create manually. This file will be explained in detail in the next section.

4. `info.md`

High level description of what your smart contract does, what are some of the features exposed by the contract and how it can be used to build something bigger.

You can present some of the use-cases or examples of how to use, or how not to use the smart contract, things to be careful about, and so on. This is also a good place to link to other docs or resources explaining your contract and/or organization.

## 4. Building manifest.json

`manifest.json` file describes all the events, constructors and functions exposed by your contract. The purpose of the file is to give meaning and context to the functions and make them more understandable for humans interacting with the contract!

We proposed a structure of this file, which is formally defined with the schema at [`contracts/schema.json`](../contracts/schema.json).

Every manifest file will contains the same root structure:
```yaml
{
    "$schema": "../../schema.json",
    "tags": [ ... ],
    "implements": [ ... ],
    "name": "My Smart Contract",
    "description": "Short description of my Smart Contract (one-liner, two sentences tops)",
    "eventDecorators": [ ... ],
    "constructorDecorators": [ ... ],
    "functionDecorators": [ ... ]
}   
```
Fields are explained below:

### **$schema**
```
$schema: "../../schema.json"
```
Points to the [`contracts/schema.json`](../contracts/schema.json) file from this repo.

### **tags**
```
tags: ["tag1", "tag2", "tag3"]
```
Tags help describe your contract and make it easier to search for the contract when filtering this ever-growing collection. Values are completely arbitrary, but make sure to try to select keywords most suitable for the purpose and the core features of your contract.

### **implements**
```
implements: ["traits.erc20", "traits.ownable"]
```
Contains the list of interfaces to which your contract conforms to. These values must be taken from the list of [allowed traits](../traits/traits.json) from this repo. For example, the list above describes the contract to be of trait erc20 (conforms to the ERC20 token interface), and of trait ownable (conforms to the ownable interface). 

If you want to introduce a new trait, add it to the allowed traits list by specifying trait name and description, and optionally an interface name which you can add to the [interfaces](../interfaces) directory. If the trait is something common (such as ownable) then it has no namespace, but if the new trait is something specific to your organization, then prepend the trait name with your organization name (for example: "dev3.issuer-common" in the traits file).

To use the common trait from the traits file, simply add it in the list as the "traits.trait-name" entry, for example: "traits.ownable".

To use the trait belonging to a namespace, add it in the list as the "traits.namespace.trait-name" entry, for example: "traits.dev3.issuer-common".

### **name**
Human readable short contract name. For example: "Mintable ERC20".

### **description**
Human readable description of the contract.

### **eventDecorators**
List of JSON objects, each of them describing one emittable event.
For example, here's a JSON describing one event called MyDepositEvent with two parameters, string and uint256:
```yaml
{
    "signature": "MyDepositEvent(address,uint256)", # valid event signature (event name and parameter types without spaces)
    "name": "My Deposit Event", # human readable event name
    "description": "Emitted when user deposits funds to the contract.", # human readable event description
    "parameterDecorators": [ # array of objects describing event parameters one by one
        {
            "name": "Depositor wallet", # first parameter name
            "description": "Wallet address of the depositor providing funds to the contract",
            "recommendedTypes": [] # empty for events (used later in other decorators)
        },
        {
            "name": "Deposited amount", # second parameter name
            "description": "Amount of funds deposited to the contract.",
            "recommendedTypes": []
        }
    ]
}
```
Make sure to describe all of the events used in the contract here. Hint: you can find all of them, together with their signatures, in the ABI file generated when compiling your contract (artifact.json).

### **constructorDecorators**

List of JSON objects, each of them describing one constructor function. If your contract contains no constructors, then leave this list empty. If your contract contains one or more constructs, then this list will contain one or more JSON objects, each of them describing one concrete constructor method.

For example, here's the JSON describing one constructor for the token vesting contract. Constructor accepts two parameters: token address and amount.

```yaml
{
    "signature": "constructor(address,uint256)", # valid constructor signature with solidity types and no spaces
    "name": "Constructor", # human readable name
    "description": "Initializes a new contract instance", # human readable description of what this constructor does
    "parameterDecorators": [
        {
            "name": "Token", // first constructor parameter
            "description": "Address of the token to be locked in this contract",
            "recommendedTypes": [
                "traits.erc20"
            ]
        },
        {
            "name": "Amount", // second constructor parameter
            "description": "Amount of the tokens to be locked in this contract",
            "recommendedTypes": []
        }
    ]
}
```

***Recommended types***

Note that we have used the `recommendedTyeps` field for the first time here when describing the first parameter of the constructor. By specifying the recommended types, we can give context to the parameters and narrow down the possibilities of what the function expects as the parameter value.

In this case, the solidity type of the parameter is the *address*, but with the `recommendedType` value we can specify that this function accepts an address which conforms to the "traits.erc20" interface. Dev3 platform's recommendation engine can then use this field to suggest values for the "Token" parameter when the user is deploying the instance of the contract and calling the constructor method.

Other than traits, one can use more primitive types to give context to the parameters, and these types can be found in [allowed types list](../types/types.json). At this point, there's only two of them: 
- `types.unixTimestamp` 
- `types.durationSeconds`

The first one states that the parameter is a numeric value but should be treated as the unix timestamp, while the second one states that the passed integer is actually a number of seconds. These recommendations will be used by the Dev3 platform to make it easier for the user to provide an input value.

For example, when the user interacts with the contract function whose parameter's recommended type is "types.unixTimestamp", the user will be presented with Date/Time picker, and if the parameter's recommended type is "types.durationSeconds" he will be presented with the Duration picker when providing the value. The pickers then automatically convert the selected Date/Time to the timestamp, or selected Duration period to the period expressed in seconds.

You can add more than one recommended item into the list of `recommendedTypes` when it makes sense to do so.
For example, when transferring tokens to a receiving account, the receiver parameter can have recommended types:

[ "traits.erc20receivable", "traits.contractCaller" ]

*erc20receivable* denotes a contract which can safely receive any erc20 token - safe in a way that tokens won't get stuck if sent to the contract.

*contractCaller* represents either an externally owned wallet, or a smart contract with the ability of acting as an externally owned wallet, meaning it can manage tokens, call other contracts and so on (for example Gnosis multisig).

The relation between types in the array is OR meaning our platform recommendation engine will recommend all the contracts having erc20receivable **OR** contractCaller traits, to be provided as the receiver value, which is fine because both of them are capable of managing the received tokens.

***Arrays***

Function parameters can be more complex than the plain solidity types. To express the array in function signature, simply append brackets next to the parameter type (without spaces). For example, this signature is a function accepting array of strings and array of uin256 as input params.
```
signature: "constructor(string[],uint256[])"
```

***Structs***

Function paramters can also be structs, containing multiple nested primitive solidity types. To make the most complex case, let's say we have to describe a constructor accepting an array of structs as its input parameter, and the struct is defined as:
```
struct User {
    address wallet;
    uint256 balance;
}
```
To describe a struct in a function signature, we'll use the special keyword *tuple*, and we'll define parameter types inside the tuple matching the ones defined for the User struct. We'll also append brackets at the end of the *tuple* construct in order to mark the parameter as an array rather than one single element. The constructor accepting the array of Users would then look something like this:
```yaml
{
    "signature": "constructor(tuple(address,uint256)[])",
    "name": "Constructor",
    "description": "Initializes the contract with the list of users",
    "parameterDecorators": [
        {
            "name": "Users list",
            "description": "An initial list of users",
            "recommendedTypes": [],
            "parameters": [
                {
                    "name": "User wallet",
                    "description": "User's wallet address",
                    "recommendedTypes": []
                },
                {
                    "name": "Amount",
                    "description": "User's wallet balance",
                    "recommendedTypes": []
                }
            ]
        }
    ]
}
```
So this constructor from the decorator above still accepts only one parameter: Users list, but this parameter is of complex type therefore we used a newly introduced keyword `parameters` to describe the nested parameters of the User struct.

### **functionDecorators**

List of JSON objects, each of them describing one smart contract function.

It is only necessary to describe public functions exposed in the smart contract's ABI. To find the list of these functions and their signatures, you can always check the generated artifact file (artifact.json) and look into the ABI section.

The functions are described in the same way as described for the constructor functions in the section above, but with a tiny addition. The function JSON objects contain two new fields: *emittableEvents* and *returnDecorators*.

*emittableEvents* contains the list of the Event signatures which the function can emit. These signatures must be valid and decorated in the "eventDecorators" section of the manifest file (explained above).

*returnDecorators* describes the list of return parameters if the function actually returns a value. If the function doesn't have a return value then the value is an empty list.

To make a full example on how to describe a function having return value and emittable event, we'll take a well known ERC20 transfer function and this is how we'd describe it:
```yaml
{
    "signature": "transfer(address,uint256)",
    "name": "Transfer tokens",
    "description": "Transfers the specified ERC20 token amount to the specified address. Transaction sender is the address from which the tokens will be sent.",
    "parameterDecorators": [
        {
            "name": "Recipient address",
            "description": "Address to which the ERC20 tokens will be sent.",
            "recommendedTypes": [
                "traits.contractCaller",
                "traits.erc20receivable"
            ]
        },
        {
            "name": "Token amount",
            "description": "The amount of ERC20 tokens to send.",
            "recommendedTypes": []
        }
    ],
    "returnDecorators": [ # transfer function returns the operation status so we describe it here
        {
            "name": "Operation succeeded",
            "description": "Indicates whether the operation was successful.",
            "recommendedTypes": []
        }
    ],
    "emittableEvents": [
        "Transfer(address,address,uint256)" # this event must be registered in the "eventDecorators" section of the manifest file
    ]
}
```


## 5. Create Pull Request

Once you're happy with the content and your contract folder is well positioned within the repository structure, with having these four files:
- ContractName.sol (flattened, compilable with solc>=0.8.0)
- artifact.json (genereted when compiling the file)
- manifest.json (built as explained in the chapter before)
- info.md

then push the changes and create a pull request for your changes to be merged to this repo.
We'll review everything together with the rest of the community, and your contract will be publicly available via the Dev3 Platform in no time.
