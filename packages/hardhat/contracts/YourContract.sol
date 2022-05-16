pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {
    event SetPurpose(address sender, string purpose);

    string public purpose = "Building Unstoppable Apps!!!";
    address private winner;
    uint256[] private numbers;
    mapping(uint256 => address) private participants;

    constructor() payable {}

    function setPurpose(string memory newPurpose) public {
        purpose = newPurpose;
        console.log(msg.sender, "set purpose to", purpose);
        emit SetPurpose(msg.sender, purpose);
    }

    function participate(uint256 number) public {
        require(number < 10 && number > 0, "out of range");
        require(participants[number] == address(0x0), "number is taken");
        numbers.push(number);
        participants[number] = msg.sender;
    }

    function getNumbers() external view returns (uint256[] memory) {
        return numbers;
    }

    function getWinner() external view returns (address) {
        return winner;
    }

    function draw() public returns (uint256) {
        uint256 rand = (block.timestamp % 9) + 1;
        winner = participants[rand];
        for (uint256 i = 0; i < numbers.length; i++) {
            participants[numbers[i]] = address(0x0);
        }
        delete numbers;
        console.log(rand, "random");
        return rand;
    }

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}
