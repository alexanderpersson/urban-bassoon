# Tools

- vs code
- solidity extension https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity
- yarn
- node v14 (ish)
- metamask (chrome plugin)

# Running the code

You need three terminals.

1. yarn chain
2. yarn deploy
3. yarn start

The first one will deploy a local ethereum compatible blockchain.
The second will run the 00_deploy_your_contracts.js file to deploy the contracts to the local blockchain.
Yarn start will start the react app.

# 🔭 Learning Solidity

📕 Read the docs: https://docs.soliditylang.org

📚 Go through each topic from [solidity by example](https://solidity-by-example.org) editing `YourContract.sol` in **🏗 scaffold-eth**

- [Primitive Data Types](https://solidity-by-example.org/primitives/)
- [Mappings](https://solidity-by-example.org/mapping/)
- [Structs](https://solidity-by-example.org/structs/)
- [Modifiers](https://solidity-by-example.org/function-modifier/)
- [Events](https://solidity-by-example.org/events/)
- [Inheritance](https://solidity-by-example.org/inheritance/)
- [Payable](https://solidity-by-example.org/payable/)
- [Fallback](https://solidity-by-example.org/fallback/)

📧 Learn the [Solidity globals and units](https://docs.soliditylang.org/en/latest/units-and-global-variables.html)

# How to do stuff

## Debugging a contract

I have no idea how to do it. But it's really easy to write JS tests that will target the contract.
If you run the site there is a tab named Debug Contract that is really neat for testing the contract and its functions.

## Example ui is really good

## Reading a property from contract

`const result = await tx(writeContracts.YourContract.purpose()`

## Calling a function on contract

`const result = await tx(writeContracts.YourContract.setPurpose(newPurpose)`

## Calling a function on contract and seding Ether

` tx(writeContracts.YourContract.setPurpose("💵 Paying for this one!", { value: utils.parseEther("0.001"), }),`

## Convert eth to wei before sending to contract

Solidity only has intergers, no floats. One eth is actually 1e18. To easy convert "real" numbers into lots of trailing zeroes use.
`ethers.utils.parseEther("0.001")`

Same goes other way, when contract returns number its a lot of numbers.
`ethers.utils.formatEther(crazyNumber)`